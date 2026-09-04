#!/bin/bash

update() {
  source "$CONFIG_DIR/icons.sh"
  source "$CONFIG_DIR/colors.sh"

  # The `airport` binary was removed in macOS 14.4, so the SSID comes from
  # ipconfig instead. macOS returns "<redacted>" unless the caller holds a
  # Location Services grant, so treat that as an unknown name rather than
  # printing it into the label.
  DEVICE="$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $2; exit}')"
  DEVICE="${DEVICE:-en0}"
  SSID="$(ipconfig getsummary "$DEVICE" 2>/dev/null | awk -F': ' '/ SSID/ {print $2; exit}')"
  [ "$SSID" = "<redacted>" ] && SSID=""
  IP="$(ipconfig getifaddr "$DEVICE")"

  if [ -n "$IP" ]; then
    ICON="$WIFI_CONNECTED"
    COLOR=$WHITE
    if [ -n "$SSID" ]; then
      LABEL="$SSID ($IP)"
    else
      LABEL="$IP"
    fi
  else
    ICON="$WIFI_DISCONNECTED"
    COLOR=$RED
    LABEL="Disconnected"
  fi

  sketchybar --set $NAME icon="$ICON" icon.color=$COLOR label="$LABEL" label.color=$COLOR
}

click() {
  # Ask Control Center to open the same native Wi-Fi menu used by Apple's
  # menu-bar icon. This requires Accessibility access for SketchyBar.
  osascript >/dev/null 2>&1 <<'APPLESCRIPT'
tell application "System Events"
  tell process "ControlCenter"
    repeat with menuItem in menu bar items of menu bar 1
      try
        if description of menuItem starts with "Wi" then
          click menuItem
          exit repeat
        end if
      end try
    end repeat
  end tell
end tell
APPLESCRIPT
}

case "$SENDER" in
  "wifi_change") update
  ;;
  "mouse.clicked") click
  ;;
esac

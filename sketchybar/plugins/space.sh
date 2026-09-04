#!/bin/bash

source "$CONFIG_DIR/colors.sh"

WORKSPACE="$1"
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null | tr -d '[:space:]')

# Build app icon label
APPS=$(aerospace list-windows --workspace "$WORKSPACE" --format '%{app-name}' 2>/dev/null)
icon_strip=""
if [ -n "$APPS" ]; then
  while IFS= read -r app; do
    [ -n "$app" ] && icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  done <<< "$APPS"
fi

if [ "$FOCUSED" = "$WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.drawing=on \
    label.drawing=on \
    background.drawing=on \
    padding_left=2 \
    padding_right=2 \
    label="$icon_strip" \
    background.border_color="$YELLOW"
elif [ -n "$APPS" ]; then
  sketchybar --set "$NAME" \
    icon.drawing=on \
    label.drawing=on \
    background.drawing=on \
    padding_left=2 \
    padding_right=2 \
    label="$icon_strip" \
    background.border_color="$BACKGROUND_2"
else
  sketchybar --set "$NAME" \
    icon.drawing=off \
    label.drawing=off \
    background.drawing=off \
    padding_left=0 \
    padding_right=0
fi

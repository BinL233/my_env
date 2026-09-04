#!/bin/bash

STATE_FILE="/tmp/sketchybar_cc_state"

if [ -f "$STATE_FILE" ]; then
  osascript -e 'tell application "System Events" to key code 53'
  rm -f "$STATE_FILE"
else
  osascript -e 'tell application "System Events" to tell process "ControlCenter" to click menu bar item 3 of menu bar 1'
  touch "$STATE_FILE"
fi

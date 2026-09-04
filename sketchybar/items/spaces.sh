#!/bin/bash

SPACE_SIDS=(1 2 3 4 5 6 7 8 9)
SPACE_COLORS=($RED $ORANGE $YELLOW $GREEN $BLUE $MAGENTA $RED $ORANGE $YELLOW)

sketchybar --remove spaces.orchestrator 2>/dev/null
for i in "${!SPACE_SIDS[@]}"; do
  sid="${SPACE_SIDS[i]}"
  sketchybar --remove "space.$sid" 2>/dev/null

  space=(
    icon="$sid"
    icon.color="${SPACE_COLORS[i]}"
    icon.padding_left=10
    icon.padding_right=10
    padding_left=2
    padding_right=2
    label.padding_right=20
    label.color=$GREY
    label.font="sketchybar-app-font:Regular:16.0"
    label.y_offset=-1
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    background.border_width=2
    click_script="aerospace workspace $sid"
  )

  sketchybar --add item "space.$sid" left \
             --set "space.$sid" "${space[@]}"
done

sketchybar --add event aerospace_workspace_change
sketchybar --add event aerospace_focus_change

sketchybar --add item aerospace left \
           --set aerospace \
             drawing=off \
             updates=on \
             script="$PLUGIN_DIR/aerospace_plugin" \
           --subscribe aerospace \
             aerospace_workspace_change \
             aerospace_focus_change

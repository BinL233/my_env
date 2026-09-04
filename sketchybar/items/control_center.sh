#!/bin/bash

sketchybar --add item control_center right \
           --set control_center \
             icon="􀜊" \
             icon.font="$FONT:Regular:16.0" \
             icon.color=$WHITE \
             label.drawing=off \
             padding_left=4 \
             padding_right=10 \
             click_script="$PLUGIN_DIR/control_center.sh"

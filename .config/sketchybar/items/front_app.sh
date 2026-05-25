#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

front_app=(
  display=active
  icon.background.drawing=on
  label.font="SF Pro:Bold:16.0"
  script="$PLUGIN_DIR/front_app/plugin.sh"
)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched system_woke

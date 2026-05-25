#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

cpu_temp=(
  label.font="SF Pro:Black:9.0"
  icon.drawing=off
  width=0
  y_offset=-10
  script="$PLUGIN_DIR/cpu_temp/plugin.sh"
)

sketchybar --add item cpu_temp right \
  --set cpu_temp "${cpu_temp[@]}" \
  --subscribe cpu_temp cpu_temp_update system_woke

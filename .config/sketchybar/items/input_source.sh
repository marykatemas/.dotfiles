#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

input_source=(
  icon.drawing=off
  label.font="SF Pro:Bold:13.0"
  script="$PLUGIN_DIR/input_source/plugin.sh"
)

sketchybar --add item input_source left \
  --set input_source "${input_source[@]}" \
  --subscribe input_source input_source_change system_woke

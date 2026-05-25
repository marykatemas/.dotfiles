#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

dnd=(
  update_freq=60
  icon="􀆺"
  label="DND"
  script="$PLUGIN_DIR/dnd/plugin.sh"
  label.font="SF Pro:Black:9.0"
  label.padding_left=-12
  label.y_offset=2
)

sketchybar --add item dnd e \
  --set dnd "${dnd[@]}" \
  --subscribe dnd system_woke

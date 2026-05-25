#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

latency=(
  update_freq=90
  label.font="SF Pro:Black:9.0"
  y_offset=-10
  icon.drawing=off
  script="$PLUGIN_DIR/latency/plugin.sh"
)

sketchybar --add item latency right \
  --set latency "${latency[@]}" \
  --subscribe latency system_woke

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

network_download=(
  icon="􀄩"
  label.font="SF Pro:Bold:13.0"
  y_offset=-8
  script="$PLUGIN_DIR/network_download/plugin.sh"
)

sketchybar --add item network_download right \
  --set network_download "${network_download[@]}" \
  --subscribe network_download network_speed_update system_woke

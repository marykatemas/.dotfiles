#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

network_upload=(
  icon="􀄨"
  label.font="SF Pro:Bold:13.0"
  y_offset=8
  width=0
  script="$PLUGIN_DIR/network_upload/plugin.sh"
)

sketchybar --add item network_upload right \
  --set network_upload "${network_upload[@]}" \
  --subscribe network_upload network_speed_update system_woke

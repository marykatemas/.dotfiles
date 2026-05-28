#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

network_status=(
  update_freq=150
  script="$PLUGIN_DIR/network_status/plugin.sh"
  y_offset=6
  width=0
)

sketchybar --add item network_status right \
  --set network_status "${network_status[@]}" \
  --subscribe network_status wifi_change system_woke

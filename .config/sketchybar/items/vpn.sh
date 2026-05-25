#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

vpn=(
  update_freq=60
  label.drawing=off
  script="$PLUGIN_DIR/vpn/plugin.sh"
)

sketchybar --add item vpn right \
  --set vpn "${vpn[@]}" \
  --subscribe vpn system_woke

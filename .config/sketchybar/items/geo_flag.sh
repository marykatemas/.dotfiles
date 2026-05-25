#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

geo_flag=(
  update_freq=300
  label.drawing=off
  script="$PLUGIN_DIR/geo_flag/plugin.sh"
)

sketchybar --add item geo_flag q \
  --set geo_flag "${geo_flag[@]}" \
  --subscribe geo_flag system_woke

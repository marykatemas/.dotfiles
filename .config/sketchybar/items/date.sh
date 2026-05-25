#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

date=(
  update_freq=300
  icon.drawing=off
  script="$PLUGIN_DIR/date/plugin.sh"
)

sketchybar --add item date q \
  --set date "${date[@]}" \
  --subscribe date system_woke

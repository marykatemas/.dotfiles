#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

time=(
  update_freq=30
  icon.drawing=off
  script="$PLUGIN_DIR/time/plugin.sh"
)

sketchybar --add item time e \
  --set time "${time[@]}" \
  --subscribe time system_woke

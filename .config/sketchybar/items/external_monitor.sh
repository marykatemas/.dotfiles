#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

external_monitor=(
  display=2
  icon.drawing=off
  label.font="SF Pro:Bold:13.0"
  script="$PLUGIN_DIR/external_monitor/plugin.sh"
)

sketchybar --add item external_monitor center \
  --set external_monitor "${external_monitor[@]}" \
  --subscribe external_monitor system_woke

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

external_monitor_gap_right=(
  display=2
  width=135
  icon.drawing=off
  label.drawing=off
  background.drawing=off
)

sketchybar --add item external_monitor_gap_right e \
  --set external_monitor_gap_right "${external_monitor_gap_right[@]}"

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

external_monitor_gap_left=(
  display=2
  width=133
  icon.drawing=off
  label.drawing=off
  background.drawing=off
)

sketchybar --add item external_monitor_gap_left q \
  --set external_monitor_gap_left "${external_monitor_gap_left[@]}"

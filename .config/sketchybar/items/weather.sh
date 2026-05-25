#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

weather=(
  icon.drawing=off
)

sketchybar --add item weather q \
  --set weather "${weather[@]}"

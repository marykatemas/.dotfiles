#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

spacer_right=(
  icon.drawing=off
  label.drawing=off
  background.drawing=off
  width=8
)

sketchybar --add item spacer_right right \
  --set spacer_right "${spacer_right[@]}"

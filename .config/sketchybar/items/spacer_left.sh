#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

spacer_left=(
  icon.drawing=off
  label.drawing=off
  background.drawing=off
  width=8
)

sketchybar --add item spacer_left left \
  --set spacer_left "${spacer_left[@]}"

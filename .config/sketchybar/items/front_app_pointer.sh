#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

pointer=(
  icon="􀆊"
  label.drawing=off
  display=active
)

sketchybar --add item front_app_pointer left \
  --set front_app_pointer "${pointer[@]}"

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

apple=(
  icon.font="SF Pro:Medium:21.0"
  icon="􀣺"
  label.drawing=off
  click_script="$PLUGIN_DIR/apple/click.sh"
)

sketchybar --add item apple left \
  --set apple "${apple[@]}"

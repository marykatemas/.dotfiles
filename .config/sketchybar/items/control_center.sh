#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

control_center=(
  icon="􀜊"
  padding_right=10
  padding_left=10
  label.drawing=off
  click_script="$PLUGIN_DIR/control_center/click.sh"
)

sketchybar --add item control_center right \
  --set control_center "${control_center[@]}"

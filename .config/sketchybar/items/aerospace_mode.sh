#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

aerospace_mode=(
  label.width=20
  label.align=center
  label.background.color="$MODE_LABEL_BG"
  label.background.corner_radius=4
  label.background.height=16
  label.font="SF Pro:Bold:13.0"
  icon.drawing=off
  script="$PLUGIN_DIR/aerospace_mode/plugin.sh"
)

sketchybar --add item aerospace_mode left \
  --set aerospace_mode "${aerospace_mode[@]}" \
  --subscribe aerospace_mode aerospace_mode_change system_woke

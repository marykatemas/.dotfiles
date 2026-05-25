#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

notifications=(
  update_freq=30
  icon="􀋚"
  label.drawing=off
  script="$PLUGIN_DIR/notifications/plugin.sh"
  click_script="$PLUGIN_DIR/notifications/click.sh"
)

sketchybar --add item notifications e \
  --set notifications "${notifications[@]}" \
  --subscribe notifications system_woke

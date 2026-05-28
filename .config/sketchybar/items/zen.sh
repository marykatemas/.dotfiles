#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

zen=(
  drawing=off
  script="$PLUGIN_DIR/zen/plugin.sh"
)

sketchybar --add item zen center \
  --set zen "${zen[@]}" \
  --subscribe zen system_woke

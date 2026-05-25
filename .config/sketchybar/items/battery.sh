#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

battery=(
  update_freq=90
  script="$PLUGIN_DIR/battery/plugin.sh"
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery power_source_change system_woke

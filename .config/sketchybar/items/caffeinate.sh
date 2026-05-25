#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

caffeinate=(
  label.drawing=off
  icon.font="Symbols Nerd Font Mono:Regular:16.0"
  script="$PLUGIN_DIR/caffeinate/plugin.sh"
  click_script="$PLUGIN_DIR/caffeinate/click.sh"
)

sketchybar --add item caffeinate right \
  --set caffeinate "${caffeinate[@]}" \
  --subscribe caffeinate system_woke

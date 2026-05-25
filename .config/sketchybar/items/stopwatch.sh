#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

stopwatch=(
  icon=""
  icon.font="Symbols Nerd Font Mono:Regular:16.0"
  script="$PLUGIN_DIR/stopwatch/plugin.sh"
  click_script="$PLUGIN_DIR/stopwatch/click.sh"
)

sketchybar --add item stopwatch left \
  --set stopwatch "${stopwatch[@]}" \
  --subscribe stopwatch system_woke

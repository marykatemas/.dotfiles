#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

audio_input=(
  script="$PLUGIN_DIR/audio_input/plugin.sh"
  click_script="$PLUGIN_DIR/audio_input/click.sh"
)

sketchybar --add item audio_input left \
  --set audio_input "${audio_input[@]}" \
  --subscribe audio_input audio_input_change system_woke

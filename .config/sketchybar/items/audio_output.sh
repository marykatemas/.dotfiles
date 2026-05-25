#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

audio_output=(
  script="$PLUGIN_DIR/audio_output/plugin.sh"
  click_script="$PLUGIN_DIR/audio_output/click.sh"
)

sketchybar --add item audio_output left \
  --set audio_output "${audio_output[@]}" \
  --subscribe audio_output volume_change audio_output_change system_woke

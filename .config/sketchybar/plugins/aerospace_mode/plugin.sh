#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

mode_name="${MODE:-main}"
mode_letter="${mode_name:0:1}"
mode_letter="$(printf '%s' "$mode_letter" | tr '[:lower:]' '[:upper:]')"

sketchybar --set "$NAME" label="$mode_letter"

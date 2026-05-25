#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

sketchybar --set "$NAME" label="$(date '+%-I:%M %p')"

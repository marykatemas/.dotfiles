#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

[ "$SENDER" = "front_app_switched" ] && [ -n "$INFO" ] || exit 0

sketchybar --set "$NAME" \
  icon.background.image="app.$INFO" \
  label="$INFO"

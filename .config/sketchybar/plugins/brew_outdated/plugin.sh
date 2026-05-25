#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

icon="􀐛"
color="$BREW_OUTDATED_INACTIVE"
label="0 OUTDATED"

num_outdated="$("$SHELL" -lc "brew outdated -q 2>/dev/null | wc -l | tr -d ' \n'")"
if [[ "$num_outdated" =~ ^[0-9]+$ ]]; then
  label="$num_outdated OUTDATED"
  if [ "$num_outdated" -gt 0 ]; then
    color="$BREW_OUTDATED_ACTIVE"
  fi
fi

sketchybar --set "$NAME" \
  icon="$icon" \
  icon.color="$color" \
  label.drawing=off \
  icon.drawing=on \
  --set "$NAME.count" \
  label="$label"

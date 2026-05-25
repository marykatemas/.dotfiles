#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

icon="􀎥"
color="$VPN_INACTIVE"

if scutil --nc list 2>/dev/null | grep -q '(Connected)'; then
  icon="􀎡"
  color="$VPN_ACTIVE"
fi

sketchybar --set "$NAME" \
  icon="$icon" \
  icon.color="$color"

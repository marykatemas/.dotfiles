#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

if [ -z "$CPU_TEMP" ]; then
  exit 0
fi

temp_value="$(printf '%s' "$CPU_TEMP" | awk 'match($0, /[0-9]+/) { print substr($0, RSTART, RLENGTH); exit }')"

if ! [[ "$temp_value" =~ ^[0-9]+$ ]]; then
  exit 0
fi

if [ "$temp_value" -ge 90 ]; then
  color="$HIGH"
elif [ "$temp_value" -ge 75 ]; then
  color="$MEDIUM"
elif [ "$temp_value" -ge 60 ]; then
  color="$LOW"
else
  color="$BASE"
fi

sketchybar --set "$NAME" label.color="$color" label="$CPU_TEMP"

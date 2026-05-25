#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

latency_seconds="$(curl -o /dev/null -s -w '%{time_total}\n' https://1.1.1.1)"

if [[ ! "$latency_seconds" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
  exit 0
fi

latency_ms="$(awk -v seconds="$latency_seconds" 'BEGIN { printf "%d", (seconds * 1000) + 0.5 }')"

if [ "$latency_ms" -ge 200 ]; then
  color="$HIGH"
elif [ "$latency_ms" -ge 100 ]; then
  color="$MEDIUM"
elif [ "$latency_ms" -ge 50 ]; then
  color="$LOW"
else
  color="$BASE"
fi

sketchybar --set "$NAME" \
  label="${latency_ms}ms" \
  label.color="$color"

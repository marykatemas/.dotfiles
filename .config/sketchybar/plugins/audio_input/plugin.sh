#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

icon_on="􀊱"
icon_muted="􀊳"
target_input_volume=69

current_input_volume() {
  osascript -e 'input volume of (get volume settings)' 2>/dev/null
}

toggle_input_volume() {
  local volume

  volume="$(current_input_volume)"
  [[ "$volume" =~ ^[0-9]+$ ]] || exit 0

  if [ "$volume" -gt 0 ]; then
    osascript -e 'set volume input volume 0' >/dev/null 2>&1
  else
    osascript -e "set volume input volume $target_input_volume" >/dev/null 2>&1
  fi

  sketchybar --trigger audio_input_change >/dev/null 2>&1
}

update_item() {
  local volume icon color

  volume="$(current_input_volume)"
  [[ "$volume" =~ ^[0-9]+$ ]] || exit 0

  icon="$icon_on"
  color="$AUDIO_UNMUTED"

  if [ "$volume" -eq 0 ]; then
    icon="$icon_muted"
    color="$AUDIO_MUTED"
  fi

  sketchybar --set "$NAME" icon="$icon" icon.color="$color" label.drawing=off

  if [ "$SENDER" = "audio_input_change" ]; then
    sketchybar --set "$NAME" label="${volume}%" label.drawing=on label.color="$color"
    pkill -f "bash -c sleep 2 && sketchybar --set $NAME label.drawing" 2>/dev/null || true
    bash -c "sleep 2 && sketchybar --set \"$NAME\" label.drawing=off" &
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  update_item
fi

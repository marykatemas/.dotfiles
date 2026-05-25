#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

icon_headphones_muted="􂬂"
icon_headphones="􀑈"
icon_speakers_muted="􀊣"
icon_speakers_level_1="􀊥"
icon_speakers_level_2="􀊧"
icon_speakers_level_3="􀊩"
target_output_volume=11

current_output_volume() {
  osascript -e 'output volume of (get volume settings)' 2>/dev/null
}

toggle_output_volume() {
  local volume

  volume="$(current_output_volume)"
  [[ "$volume" =~ ^[0-9]+$ ]] || exit 0

  if [ "$volume" -gt 0 ]; then
    osascript -e 'set volume output volume 0' >/dev/null 2>&1
  else
    osascript -e "set volume output volume $target_output_volume" >/dev/null 2>&1
  fi

  sketchybar --trigger audio_output_change >/dev/null 2>&1
}

update_item() {
  local volume current_output color icon

  volume="$(current_output_volume)"
  [[ "$volume" =~ ^[0-9]+$ ]] || exit 0

  current_output=""
  if command -v SwitchAudioSource >/dev/null 2>&1; then
    current_output="$(SwitchAudioSource -t output -c 2>/dev/null)"
  fi

  if [ "$volume" -eq 0 ]; then
    color="$AUDIO_MUTED"
  else
    color="$AUDIO_UNMUTED"
  fi

  case "$current_output" in
  *AirPods* | *Headphones* | *Earbuds* | *Buds* | *Pods* | *Headset* | *External*)
    if [ "$volume" -eq 0 ]; then
      icon="$icon_headphones_muted"
    else
      icon="$icon_headphones"
    fi
    ;;
  *)
    if [ "$volume" -eq 0 ]; then
      icon="$icon_speakers_muted"
    elif [ "$volume" -le 33 ]; then
      icon="$icon_speakers_level_1"
    elif [ "$volume" -le 66 ]; then
      icon="$icon_speakers_level_2"
    else
      icon="$icon_speakers_level_3"
    fi
    ;;
  esac

  sketchybar --set "$NAME" icon="$icon" icon.color="$color"

  if [ "$SENDER" = "volume_change" ] || [ "$SENDER" = "audio_output_change" ]; then
    sketchybar --set "$NAME" label="${volume}%" label.drawing=on label.color="$color"
    pkill -f "bash -c sleep 2 && sketchybar --set $NAME label.drawing" 2>/dev/null || true
    bash -c "sleep 2 && sketchybar --set \"$NAME\" label.drawing=off" &
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  update_item
fi

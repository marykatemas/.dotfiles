#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

item="${NAME:-stopwatch}"
lock="$STATE_DIR/stopwatch.lock"

hide() {
  sketchybar --set "$item" icon.color="$STOPWATCH_INACTIVE" label.color="$STOPWATCH_INACTIVE" label="" label.drawing=off
}

update() {
  local now e h m label started
  IFS='|' read -r _ started <"$lock" 2>/dev/null || {
    hide
    return
  }
  [ -n "$started" ] || {
    hide
    return
  }
  now=$(date +%s)
  total=$((now - started))
  h=$((total / 3600))
  m=$(((total % 3600) / 60))
  s=$((total % 60))
  if [ "$h" -gt 0 ]; then
    label="${h}h ${m}m ${s}s"
  elif [ "$m" -gt 0 ]; then
    label="${m}m ${s}s"
  else label="${s}s"; fi
  sketchybar --set "$item" icon.color="$STOPWATCH_ACTIVE" label.color="$STOPWATCH_ACTIVE" label="$label" label.drawing=on
}

loop() {
  local mypid=$$
  mkdir -p "$STATE_DIR"
  printf '%s|%s\n' "$mypid" "${1:-}" >"$lock"
  update
  while :; do
    sleep 1
    IFS='|' read -r pid _ <"$lock" 2>/dev/null || break
    [ "$pid" = "$mypid" ] || break
    update
  done
  IFS='|' read -r pid _ <"$lock" 2>/dev/null
  [ "$pid" = "$mypid" ] && {
    rm -f "$lock"
    hide
  }
}

toggle_stopwatch() {
  local pid
  IFS='|' read -r pid _ <"$lock" 2>/dev/null
  if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
    kill "$pid" 2>/dev/null
    rm -f "$lock"
    hide
  else
    "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/plugin.sh" loop "$(date +%s)" >/dev/null 2>&1 &
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  case "${1:-update}" in
  loop) loop "${2:-}" ;;
  *) update ;;
  esac
fi

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

item_name="${NAME:-caffeinate}"
state_file="$STATE_DIR/caffeinate.lock"
active_icon="􂊭"
inactive_icon=""

read_state() {
  cat "$state_file" 2>/dev/null
}

process_command() {
  ps -p "$1" -o command= 2>/dev/null
}

active_pid() {
  local pid current_command

  pid="$(read_state)"

  [[ "$pid" =~ ^[0-9]+$ ]] || return 1
  kill -0 "$pid" 2>/dev/null || return 1

  current_command="$(process_command "$pid")"

  [[ "$current_command" == *"/caffeinate"* || "$current_command" == "caffeinate"* ]] || return 1

  printf '%s\n' "$pid"
}

stop_caffeinate() {
  local pid

  pid="$(active_pid)"
  if [[ "$pid" =~ ^[0-9]+$ ]]; then
    kill "$pid" 2>/dev/null || true
  fi

  rm -f "$state_file"
  set_item "$CAFFEINATE_INACTIVE" "$inactive_icon"
}

start_caffeinate() {
  local pid

  mkdir -p "$STATE_DIR"
  caffeinate -dimsu >/dev/null 2>&1 &
  pid="$!"
  printf '%s\n' "$pid" >"$state_file"
  set_item "$CAFFEINATE_ACTIVE" "$active_icon"
}

toggle_caffeinate() {
  local pid

  pid="$(active_pid)"
  if [[ "$pid" =~ ^[0-9]+$ ]]; then
    stop_caffeinate
  else
    rm -f "$state_file"
    start_caffeinate
  fi
}

set_item() {
  local color="$1"
  local icon="$2"

  sketchybar --set "$item_name" \
    icon="$icon" \
    icon.color="$color" || true
}

update_item() {
  local pid

  pid="$(active_pid)"
  if [[ "$pid" =~ ^[0-9]+$ ]]; then
    set_item "$CAFFEINATE_ACTIVE" "$active_icon"
  else
    rm -f "$state_file"
    set_item "$CAFFEINATE_INACTIVE" "$inactive_icon"
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  update_item
fi

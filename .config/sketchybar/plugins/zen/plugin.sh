#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

ZEN_WHITELIST=(
  'aerospace_mode'
  'aerospace_workspace'
  'front_app_pointer'
  'front_app'
)

ZEN_STATE_FILE="$STATE_DIR/zen.state"

read_zen_state() {
  if [ -f "$ZEN_STATE_FILE" ]; then
    cat "$ZEN_STATE_FILE"
  else
    echo "off"
  fi
}

get_all_items() {
  sketchybar --query bar 2>/dev/null |
    python3 -c "import sys,json;[print(i) for i in json.load(sys.stdin).get('items',[])]" 2>/dev/null || true
}

apply_zen() {
  local state="$1"
  local all_items

  all_items="$(get_all_items)"

  if [ "$state" = "on" ]; then
    while IFS= read -r item; do
      [[ -z "$item" ]] && continue
      local whitelisted=false
      for wl_item in "${ZEN_WHITELIST[@]}"; do
        if [ "$item" = "$wl_item" ]; then
          whitelisted=true
          break
        fi
      done
      if [ "$whitelisted" = false ]; then
        sketchybar --set "$item" drawing=off
      fi
    done <<<"$all_items"
  else
    while IFS= read -r item; do
      [[ -z "$item" ]] && continue
      sketchybar --set "$item" drawing=on
    done <<<"$all_items"
    sketchybar --set zen drawing=off
  fi
}

toggle_zen() {
  local current

  current="$(read_zen_state)"
  if [ "$current" = "on" ]; then
    echo "off" >"$ZEN_STATE_FILE"
    apply_zen "off"
  else
    mkdir -p "$STATE_DIR"
    echo "on" >"$ZEN_STATE_FILE"
    apply_zen "on"
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  zen_state="$(read_zen_state)"
  apply_zen "$zen_state"
fi

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"
source "$CONFIG_DIR/icon_map.sh"

[ -n "$FOCUSED" ] || exit 0

args=()

args+=(
  --set workspace.focused drawing=on icon="$FOCUSED"
)

if [ -n "$PREV" ] && [ "$PREV" != "$FOCUSED" ]; then
  icon_strip=""
  apps=$(aerospace list-windows --workspace "$PREV" --format '%{app-name}' 2>/dev/null | sort -u)
  if [ -n "$apps" ]; then
    while IFS= read -r app; do
      __icon_map "$app"
      icon_strip+="$icon_result"
    done <<<"$apps"
  fi

  if [ -n "$icon_strip" ]; then
    args+=(
      --set workspace.prev drawing=on background.drawing=on
      icon="$icon_strip" icon.drawing=on
      label="$PREV" label.drawing=on
    )
  else
    args+=(
      --set workspace.prev drawing=on background.drawing=on
      label="$PREV" label.drawing=on icon.drawing=off
    )
  fi
else
  args+=(--set workspace.prev drawing=off)
fi

sketchybar "${args[@]}"

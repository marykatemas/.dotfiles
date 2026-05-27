#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

workspace_prev=(
  drawing=off
  label.align=center
  label.color="$WORKSPACE_PREV_TEXT"
  label.background.color="$WORKSPACE_PREV_BG"
  label.background.height=20
  label.background.corner_radius=5
  label.background.drawing=on
  label.width=26
  label.drawing=off
  icon.font="sketchybar-app-font:Regular:21.0"
  icon.color="$WORKSPACE_PREV_MAP_ICON"
  background.drawing=off
  background.color="$WORKSPACE_PREV_CAPSULE_BG"
  background.height=24
  background.corner_radius=6
)

workspace_focused=(
  drawing=off
  icon.align=center
  icon.color="$WORKSPACE_FOCUSED_TEXT"
  icon.background.color="$WORKSPACE_FOCUSED_BG"
  icon.background.height=24
  icon.background.corner_radius=6
  icon.background.drawing=on
  icon.width=30
  label.drawing=off
  script="$PLUGIN_DIR/aerospace_workspace/plugin.sh"
)

sketchybar --add item workspace.prev left \
  --set workspace.prev "${workspace_prev[@]}" \
  --add item workspace.focused left \
  --set workspace.focused "${workspace_focused[@]}" \
  --subscribe workspace.focused aerospace_workspace_change system_woke

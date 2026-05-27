#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

brew_outdated=(
  update_freq=1800
  script="$PLUGIN_DIR/brew_outdated/plugin.sh"
  click_script="$PLUGIN_DIR/brew_outdated/click.sh"
  popup.background.drawing=on
  popup.background.color="$BRACKET_BG"
  popup.background.border_color="$BRACKET_BORDER"
  popup.background.height=32
  popup.background.corner_radius=8
  popup.background.border_width=1
)

sketchybar --add item brew_outdated right \
  --set brew_outdated "${brew_outdated[@]}" \
  --add item brew_outdated.count popup.brew_outdated \
  --set brew_outdated.count \
  icon.drawing=off \
  label="0 OUTDATED" \
  --subscribe brew_outdated system_woke

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

layout_source=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist \
  AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null) || layout_source=""

case $layout_source in
'com.apple.keylayout.US')      label='EN' ;;
'com.apple.keylayout.Russian') label='RU' ;;
*)                             label='??' ;;
esac

sketchybar --set "$NAME" label="$label"

#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

assertions_file="$HOME/Library/DoNotDisturb/DB/Assertions.json"
color="$DND_INACTIVE"

if [ -r "$assertions_file" ]; then
  assertion_records="$(plutil -extract data.0.storeAssertionRecords json -o - "$assertions_file" 2>/dev/null)"

  if [ -z "$assertion_records" ]; then
    assertion_records="$(plutil -extract storeAssertionRecords json -o - "$assertions_file" 2>/dev/null)"
  fi

  if [ -n "$assertion_records" ] && [ "$assertion_records" != "[]" ]; then
    color="$DND_ACTIVE"
  fi
fi

sketchybar --set "$NAME" \
  icon.color="$color" \
  label.color="$color"

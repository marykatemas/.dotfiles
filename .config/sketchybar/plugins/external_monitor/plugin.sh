#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

external_name="$(system_profiler SPDisplaysDataType | awk '
  /Displays:/ { in_displays=1; next }
  !in_displays { next }
  /^        [^:][^:]*:$/ {
    if (name != "" && !internal) {
      print name
      exit
    }
    name=$0
    gsub(/^[[:space:]]+|:$/, "", name)
    internal=0
    next
  }
  /Connection Type: Internal/ { internal=1 }
  END {
    if (name != "" && !internal) print name
  }
')"

display_id="$(sketchybar --query displays | awk -F'[:,]' '/"arrangement-id"/ { id=$2 + 0 } END { print id }')"

sketchybar --set "$NAME" display="$display_id" label="$external_name"

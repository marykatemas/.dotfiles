#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

icon_charging="􀋦"
icon_plugged="􀘴"
icon_battery="􀋪"

battery_info="$(pmset -g batt)"

percentage="$(printf '%s\n' "$battery_info" | awk 'NR==2 {match($0, /[0-9]+%/); if (RSTART) print substr($0, RSTART, RLENGTH - 1)}')"
charge_state="$(printf '%s\n' "$battery_info" | awk -F';' 'NR==2 {gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2); print $2}')"

if ! [[ "$percentage" =~ ^[0-9]+$ ]]; then
  exit 0
fi

case "$battery_info" in
*"Battery Power"*)
  icon="$icon_battery"
  ;;
*)
  case "$charge_state" in
  charging | finishing\ charge)
    icon="$icon_charging"
    ;;
  *)
    icon="$icon_plugged"
    ;;
  esac
  ;;
esac

sketchybar --set "$NAME" icon="$icon" icon.color="$BASE" label="${percentage}%"

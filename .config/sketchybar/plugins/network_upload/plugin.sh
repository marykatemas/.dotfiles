#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

first_env_value() {
  local prefix="$1"
  printenv | awk -F= -v prefix="$prefix" '$1 ~ ("^" prefix) { print $2; exit }'
}

rate_to_bytes_per_second() {
  local value="$1"
  local number unit

  if [[ "$value" =~ ^([0-9]+([.][0-9]+)?)(B/s|KB/s|MB/s|GB/s|TB/s)$ ]]; then
    number="${BASH_REMATCH[1]}"
    unit="${BASH_REMATCH[3]}"
  elif [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    awk -v n="$value" 'BEGIN { printf "%.0f", n * 1024 }'
    return
  else
    printf '0\n'
    return
  fi

  awk -v n="$number" -v unit="$unit" '
    BEGIN {
      m = 1
      if (unit == "KB/s") m = 1024
      else if (unit == "MB/s") m = 1024 * 1024
      else if (unit == "GB/s") m = 1024 * 1024 * 1024
      else if (unit == "TB/s") m = 1024 * 1024 * 1024 * 1024
      printf "%.0f", n * m
    }
  '
}

rate_value="${NETWORK_UPLOAD:-$(first_env_value "NETWORK_UPLOAD_")}"

bytes_per_second="$(rate_to_bytes_per_second "$rate_value")"

if [ "$bytes_per_second" -ge $((32000 * 1024)) ]; then
  color="$HIGH"
elif [ "$bytes_per_second" -ge $((16000 * 1024)) ]; then
  color="$MEDIUM"
elif [ "$bytes_per_second" -ge $((8000 * 1024)) ]; then
  color="$LOW"
else
  color="$BASE"
fi

sketchybar --set "$NAME" label="$rate_value" label.color="$color"

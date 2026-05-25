#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

country_code="$(curl -fsSL --max-time 2 https://www.cloudflare.com/cdn-cgi/trace 2>/dev/null | awk -F= '/^loc=/{print $2; exit}' | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')"
flag="..."

if [[ "$country_code" =~ ^[A-Z]{2}$ ]]; then
  converted_flag="$(
    python3 - "$country_code" <<'PY'
import sys

code = sys.argv[1]
print(''.join(chr(127397 + ord(c)) for c in code), end='')
PY
  )"

  if [ -n "$converted_flag" ]; then
    flag="$converted_flag"
  fi
fi

sketchybar --set "$NAME" icon="$flag"

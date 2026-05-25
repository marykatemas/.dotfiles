#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

icon_wifi="􀙇"
icon_ethernet="􀤆"
icon_disconnected="􁣡"
icon_hotspot="􀉤"

wifi_device() {
  echo "$1" | awk '
    /Hardware Port: Wi-Fi/ {
      getline
      if ($1 == "Device:") print $2
      exit
    }
  '
}

ethernet_devices() {
  echo "$1" | awk '
    /Hardware Port: Ethernet/ {
      getline
      if ($1 == "Device:") print $2
    }
  '
}

wifi_connected() {
  local device="$1"

  [ -n "$device" ] || return 1

  ipconfig getsummary "$device" 2>/dev/null | awk '
    /InterfaceType : WiFi/ { wifi = 1 }
    /LinkStatusActive : TRUE/ { link = 1 }
    /SSID : / { ssid = 1 }
    END { exit !(wifi && link && ssid) }
  '
}

wifi_is_hotspot() {
  local device="$1"
  [ -n "$device" ] || return 1
  ipconfig getsummary "$device" 2>/dev/null | grep -q "IsExpensive : TRUE"
}

ethernet_connected() {
  local device

  for device in "$@"; do
    [ -n "$device" ] || continue
    if ifconfig "$device" 2>/dev/null | awk '/status:/{print $2; exit}' | grep -qx 'active'; then
      return 0
    fi
  done

  return 1
}

network_hardware="$(networksetup -listallhardwareports 2>/dev/null)"

wifi_device_name="$(wifi_device "$network_hardware")"
ethernet_devices_raw="$(ethernet_devices "$network_hardware")"
ethernet_device_names=()
while IFS= read -r ethernet_device; do
  [ -n "$ethernet_device" ] || continue
  ethernet_device_names+=("$ethernet_device")
done <<EOF
$ethernet_devices_raw
EOF

icon="$icon_disconnected"
color="$NETWORK_DISCONNECTED"

if ethernet_connected "${ethernet_device_names[@]}"; then
  icon="$icon_ethernet"
  color="$NETWORK_CONNECTED"
elif wifi_connected "$wifi_device_name"; then
  if wifi_is_hotspot "$wifi_device_name"; then
    icon="$icon_hotspot"
  else
    icon="$icon_wifi"
  fi
  color="$NETWORK_CONNECTED"
fi

sketchybar --set "$NAME" icon="$icon" icon.color="$color"

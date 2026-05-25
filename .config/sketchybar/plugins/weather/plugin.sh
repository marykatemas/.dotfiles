#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

ICON_DAY_CLEAR="􀆮"
ICON_DAY_PARTLY_CLOUDY="􀇕"
ICON_DAY_OVERCAST="􀇣"
ICON_DAY_FOG="􀇋"
ICON_DAY_DRIZZLE="􀇗"
ICON_DAY_FREEZING_DRIZZLE="􀇗"
ICON_DAY_RAIN="􀇇"
ICON_DAY_FREEZING_RAIN="􀇇"
ICON_DAY_SNOW="􀇥"
ICON_DAY_SNOW_GRAINS="􀇏"
ICON_DAY_RAIN_SHOWERS="􀇗"
ICON_DAY_SNOW_SHOWERS="􀇏"
ICON_DAY_THUNDERSTORM="􀇟"
ICON_DAY_THUNDERSTORM_HAIL="􀇟"
ICON_DAY_UNKNOWN="?"

ICON_NIGHT_CLEAR="􀇁"
ICON_NIGHT_PARTLY_CLOUDY="􀇛"
ICON_NIGHT_OVERCAST="􀇣"
ICON_NIGHT_FOG="􀇋"
ICON_NIGHT_DRIZZLE="􀇝"
ICON_NIGHT_FREEZING_DRIZZLE="􀇝"
ICON_NIGHT_RAIN="􀇇"
ICON_NIGHT_FREEZING_RAIN="􀇇"
ICON_NIGHT_SNOW="􀇥"
ICON_NIGHT_SNOW_GRAINS="􀇏"
ICON_NIGHT_RAIN_SHOWERS="􀇝"
ICON_NIGHT_SNOW_SHOWERS="􀇏"
ICON_NIGHT_THUNDERSTORM="􀇟"
ICON_NIGHT_THUNDERSTORM_HAIL="􀇟"
ICON_NIGHT_UNKNOWN="?"

weather_icon() {
  local code="$1" is_day="$2"
  local prefix="NIGHT"
  [ "$is_day" = "1" ] && prefix="DAY"

  local var
  case "$code" in
  0)        var="ICON_${prefix}_CLEAR" ;;
  1|2)      var="ICON_${prefix}_PARTLY_CLOUDY" ;;
  3)        var="ICON_${prefix}_OVERCAST" ;;
  45|48)    var="ICON_${prefix}_FOG" ;;
  51|53|55) var="ICON_${prefix}_DRIZZLE" ;;
  56|57)    var="ICON_${prefix}_FREEZING_DRIZZLE" ;;
  61|63|65) var="ICON_${prefix}_RAIN" ;;
  66|67)    var="ICON_${prefix}_FREEZING_RAIN" ;;
  71|73|75) var="ICON_${prefix}_SNOW" ;;
  77)       var="ICON_${prefix}_SNOW_GRAINS" ;;
  80|81|82) var="ICON_${prefix}_RAIN_SHOWERS" ;;
  85|86)    var="ICON_${prefix}_SNOW_SHOWERS" ;;
  95)       var="ICON_${prefix}_THUNDERSTORM" ;;
  96|99)    var="ICON_${prefix}_THUNDERSTORM_HAIL" ;;
  *)        var="ICON_${prefix}_UNKNOWN" ;;
  esac

  printf '%s\n' "${!var}"
}

valid_coord() {
  [[ "$1" =~ ^-?[0-9]+([.][0-9]+)?$ ]]
}

geo_get() {
  plutil -extract "$1" raw -o - - <<<"$geo_json" 2>/dev/null
}

set_location_from() {
  geo_json="$(curl -fsS --retry 1 --retry-delay 1 --max-time 5 "$1" 2>/dev/null)"
  [ -n "$geo_json" ] || return 1
  latitude="$(geo_get latitude)"
  longitude="$(geo_get longitude)"
  valid_coord "$latitude" && valid_coord "$longitude"
}

set_location() {
  if valid_coord "$WEATHER_LATITUDE" && valid_coord "$WEATHER_LONGITUDE"; then
    latitude="$WEATHER_LATITUDE"
    longitude="$WEATHER_LONGITUDE"
    return 0
  fi
  set_location_from 'https://ipapi.co/json/' && return 0
  set_location_from 'https://get.geojs.io/v1/ip/geo.json' && return 0
  set_location_from 'https://ipwho.is/' && return 0
  return 1
}

update_item() {
  local weather_json temperature weather_code is_day icon item \
    latitude longitude

  item="${NAME:-weather}"

  set_location || { sketchybar --set "$item" label="..."; return; }

  weather_json="$(curl -fsS --retry 1 --retry-delay 1 --max-time 5 "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code,is_day" 2>/dev/null)"
  [ -n "$weather_json" ] || { sketchybar --set "$item" label="..."; return; }

  temperature="$(plutil -extract current.temperature_2m raw -o - - <<<"$weather_json" 2>/dev/null)"
  weather_code="$(plutil -extract current.weather_code raw -o - - <<<"$weather_json" 2>/dev/null)"
  is_day="$(plutil -extract current.is_day raw -o - - <<<"$weather_json" 2>/dev/null)"

  if ! valid_coord "$temperature" || ! valid_coord "$weather_code" || ! [[ "$is_day" =~ ^[01]$ ]]; then
    sketchybar --set "$item" label="..."
    return
  fi

  icon="$(weather_icon "$weather_code" "$is_day")"
  temp_display="$(printf '%.0f' "$temperature")"
  sketchybar --set "$item" label="$icon ${temp_display}°C"
}

if [ "${1:-}" = "loop" ]; then
  while true; do
    update_item
    sleep 900
  done
else
  update_item
fi

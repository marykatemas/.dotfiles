#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

cpu_usage_top=(
  label.font="SF Pro:Black:9.0"
  width=0
  icon.drawing=off
  y_offset=12
)

cpu_usage_percent=(
  update_freq=4
  label.font="SF Pro:Bold:13.0"
  width=45
  icon.drawing=off
  mach_helper="$HELPER"
)

cpu_usage_sys=(
  width=0
  y_offset=6
  graph.color="$CPU_USAGE_SYS_DELTA"
  graph.fill_color="$CPU_USAGE_SYS_FILL"
  label.drawing=off
  icon.drawing=off
  background.drawing=off
)

cpu_usage_user=(
  y_offset=6
  graph.color="$CPU_USAGE_USER_DELTA"
  graph.fill_color="$CPU_USAGE_USER_FILL"
  label.drawing=off
  icon.drawing=off
  background.drawing=off
)

sketchybar --add item cpu.top right \
  --set cpu.top "${cpu_usage_top[@]}" \
  \
  --add item cpu.percent right \
  --set cpu.percent "${cpu_usage_percent[@]}" \
  \
  --add graph cpu.sys right 99 \
  --set cpu.sys "${cpu_usage_sys[@]}" \
  \
  --add graph cpu.user right 99 \
  --set cpu.user "${cpu_usage_user[@]}"

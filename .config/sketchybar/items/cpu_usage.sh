#!/usr/bin/env bash

source "$HOME/.config/sketchybar/sourcefile.sh"

cpu_usage_top=(
  label.font="SF Pro:Black:9.0"
  icon.drawing=off
  width=0
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
  y_offset=8
  graph.color="$CPU_USAGE_SYS_DELTA"
  graph.fill_color="$CPU_USAGE_SYS_DELTA"
  label.drawing=off
  icon.drawing=off
  background.height=45
  background.drawing=on
  background.color="$CPU_USAGE_SYS_DELTA_BG"
)

cpu_usage_user=(
  graph.color="$CPU_USAGE_USER_DELTA"
  y_offset=8
  label.drawing=off
  icon.drawing=off
  background.height=45
  background.drawing=on
  background.color="$CPU_USAGE_USER_DELTA_BG"
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

#!/usr/bin/env bash

osascript >/dev/null 2>&1 <<'APPLESCRIPT'
tell application "System Events"
  tell process "ControlCenter"
    try
      perform action "AXPress" of (first menu bar item of menu bar 1 whose description contains "Control Center")
    on error
      perform action "AXPress" of menu bar item 2 of menu bar 1
    end try
  end tell
end tell
APPLESCRIPT

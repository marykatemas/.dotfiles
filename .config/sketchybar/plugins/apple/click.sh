#!/usr/bin/env bash

osascript -e 'tell application "System Events" to tell process (name of first application process whose frontmost is true) to click menu bar item 1 of menu bar 1'

#!/usr/bin/env bash

vol=$(osascript -e 'output volume of (get volume settings)')
if [ "$vol" -gt 0 ]; then
	osascript -e 'set volume output volume 0'
	osascript -e 'display notification "OUTPUT 0% vol." with title "MUTED"'
else
	osascript -e 'set volume output volume 25'
	osascript -e 'display notification "OUTPUT 25% vol." with title "UNMUTED"'
fi

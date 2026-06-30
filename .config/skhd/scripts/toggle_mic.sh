#!/usr/bin/env bash

vol=$(osascript -e 'input volume of (get volume settings)')
if [ "$vol" -gt 0 ]; then
	osascript -e 'set volume input volume 0'
	osascript -e 'display notification "Mic 0% vol" with title "MUTED"'
else
	osascript -e 'set volume input volume 75'
	osascript -e 'display notification "Mic 75% vol" with title "UNMUTED"'
fi

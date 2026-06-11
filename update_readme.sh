#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_README="$SCRIPT_DIR/README.md"

README_FILES=(
	"$SCRIPT_DIR/.config/sketchybar/README.md"
	"$SCRIPT_DIR/.config/tmux/README.md"
	"$SCRIPT_DIR/.config/television/README.md"
)

{
	echo "# .dotfiles"
	echo
	echo "> [!WARNING]"
	echo "> install.sh currently only for manual install."
	echo
	echo "![asset](assets/asset.png)"
	echo
	echo
	echo

	first=true
	for file in "${README_FILES[@]}"; do
		[ -f "$file" ] || continue

		$first || echo
		first=false

		DIR_NAME="${file#$SCRIPT_DIR/}"

		echo "## $DIR_NAME"
		echo

		while IFS= read -r line; do
			if [[ "$line" =~ !\[.*\]\(.*\) ]]; then
				url="${line#*](}"
				url="${url%)}"
				if [[ "$url" == ../* || "$url" == ./* ]]; then
					abs="$(realpath "$(dirname "$file")/$url")"
					url="${abs#$SCRIPT_DIR/}"
				fi
				echo "${line%](*)}]($url)"
			else
				echo "$line"
			fi
		done <"$file"
	done
} >"$MAIN_README"

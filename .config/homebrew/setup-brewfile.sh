#!/usr/bin/env bash

set -euo pipefail

BREWFILE="$HOME/.dotfiles/.config/homebrew/Brewfile"

failed=()

while IFS= read -r line; do
	[[ -z "${line// /}" ]] && continue
	[[ "$line" =~ ^[[:space:]]*# ]] && continue

	echo "==> $line"

	if ! printf '%s\n' "$line" | brew bundle --file=- >/dev/null; then
		failed+=("$line")
	fi
done <"$BREWFILE"

echo

if ((${#failed[@]} == 0)); then
	echo "brewed ✓"
	exit 0
fi

echo "FAILED:"
printf '  %s\n' "${failed[@]}"

exit 1

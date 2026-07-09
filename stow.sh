#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles.bak"
BACKUP_SUFFIX="$(date +%Y%m%d-%H%M%S)"

cd "$DOTFILES_DIR"

mkdir -p "$BACKUP_DIR"

for item in * .[^.]*; do
	[[ "$item" == "." || "$item" == ".." ]] && continue

	target="$HOME/$item"

	if [ -e "$target" ] && [ ! -L "$target" ]; then
		backup="$BACKUP_DIR/${item}.bak.${BACKUP_SUFFIX}"
		echo "backing up $target to $backup"
		mv "$target" "$backup"
	fi
done

stow -t "$HOME" .

echo "stowed ✓"

#!/usr/bin/env bash

set -euo pipefail

if ! command -v nix; then
	if [[ "$OSTYPE" == "darwin"* ]]; then
		curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh
		source "/nix/var/nix/profiles/default/etc/profile.d/nix.sh"
	else
		curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
		source "$HOME/.nix-profile/etc/profile.d/nix.sh"
	fi
fi

export NIX_CONFIG="
extra-experimental-features = nix-command flakes
build-users-group = nixbld
"

nix shell nixpkgs#git nixpkgs#stow

cd /

if [[ -d ~/.dotfiles ]]; then
	mv ~/.dotfiles ~/.dotfiles.bak.$(date +%Y%m%d-%H%M%S)
fi

cd ~ && git clone https://github.com/marykatemas/.dotfiles.git

cd ~/.dotfiles/ && ./stow.sh

if [[ "$OSTYPE" == "darwin"* ]]; then

	# if macOS
	if ! command -v brew; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
	brew analytics off
	nix run nix-darwin/master -- switch --flake ~/.config/nix/.#marykatemas-macos
else

	# if linux
	nix run home-manager/master -- switch --flake ~/.config/nix/.#marykatemas-linux
fi

# shared

# setup mise
if command -v mise; then
	mise install
fi

# setup gh
if command -v gh; then
	gh extension install dlvhdr/gh-dash
fi

# setup nushell
if command -v nu; then
	if [[ "$OSTYPE" == "darwin"* ]]; then
		rm -rf "$HOME/Library/Application Support/nushell" && ln -sf "$HOME/.dotfiles/.config/nushell" "$HOME/Library/Application Support/nushell"
	fi

	NU_PATH="$(which nu)"
	if ! grep -qxF "$NU_PATH" /etc/shells; then
		echo "$NU_PATH" | sudo tee -a /etc/shells
	fi
	chsh -s "$NU_PATH"
fi

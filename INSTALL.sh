#!/usr/bin/env bash

set -euo pipefail

if [[ "$OSTYPE" == "darwin"* ]]; then
	if ! xcode-select -p; then
		sudo xcode-select --install
		until xcode-select -p; do
			sleep 10
		done
	fi
	if [[ "$(uname -m)" == "arm64" ]]; then
		if ! pgrep oahd; then
			sudo softwareupdate --install-rosetta --agree-to-license
		fi
	fi
	if ! command -v brew; then
		sudo -v
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		if [[ -x /opt/homebrew/bin/brew ]]; then
			eval "$(/opt/homebrew/bin/brew shellenv)"
		elif [[ -x /usr/local/bin/brew ]]; then
			eval "$(/usr/local/bin/brew shellenv)"
		fi
	fi
	brew analytics off
	if ! command -v nix; then
		curl -fsSL https://install.determinate.systems/nix | sh -s -- install
	fi
	source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
else
	if ! command -v nix; then
		curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
	fi
	source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

export NIX_CONFIG="
extra-experimental-features = nix-command flakes
"

nix shell nixpkgs#git nixpkgs#stow

cd /

if [[ -d ~/.dotfiles ]]; then
	mv ~/.dotfiles ~/.dotfiles.bak.$(date +%Y%m%d-%H%M%S)
fi

cd ~ && git clone https://github.com/marykatemas/.dotfiles.git

cd ~/.dotfiles/ && ./stow.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
	sudo nix run nix-darwin/master -- switch --flake ~/.config/nix/.#default --impure
else
	nix run home-manager/master -- switch --flake ~/.config/nix/.#default --impure
fi

#################
### 3RD PARTY ###
#################

if command -v mise; then
	mise install
fi

if command -v gh; then
	gh extension install dlvhdr/gh-dash
fi

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

if command -v skhd; then
	if [[ "$OSTYPE" == "darwin"* ]]; then
		skhd --start-service
	fi
fi

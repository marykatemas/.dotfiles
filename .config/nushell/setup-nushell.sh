#!/usr/bin/env bash

rm -rf "$HOME/Library/Application Support/nushell" && ln -sf "$HOME/.dotfiles/.config/nushell" "$HOME/Library/Application Support/nushell"

NU_PATH="$(which nu)"
echo "$NU_PATH" | sudo tee -a /etc/shells
chsh -s "$NU_PATH"

#!/usr/bin/env bash

set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

chmod go-w "$(brew --prefix)/share"
chmod -R go-w "$(brew --prefix)/share/zsh"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zshrc"
source "$HOME/.zshrc"

brew analytics off

brew bundle --file="$HOME/.dotfiles/Brewfile"

# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# gh extension install dlvhdr/gh-dash

sudo scutil --set LocalHostName marykate-mac
sudo scutil --set ComputerName "marykate macbook"
sudo scutil --set HostName marykate.local

sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "marykate-mac"
sudo killall -HUP mDNSResponder

sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.1 1.0.0.1

defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool false

#!/usr/bin/env bash

set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
chmod -R go-w "$(brew --prefix)/share/zsh"
brew analytics off

brew bundle --file="$HOME/.dotfiles/Brewfile"

sudo scutil --set LocalHostName marykate-mac
sudo scutil --set ComputerName "marykate macbook"
sudo scutil --set HostName marykate.local
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "marykate-mac"
sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.1 1.0.0.1
sudo killall -HUP mDNSResponder

defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool false

defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# gh extension install dlvhdr/gh-dash

brew services start sketchybar borders atuin

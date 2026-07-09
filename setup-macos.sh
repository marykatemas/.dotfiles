#!/usr/bin/env bash

set -euo pipefail

sudo scutil --set LocalHostName marykate-mac
sudo scutil --set ComputerName "marykate macbook"
sudo scutil --set HostName marykate.local
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "marykate-mac"
sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.1 1.0.0.1
sudo killall -HUP mDNSResponder

defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g com.apple.swipescrolldirection -bool false
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write -g com.apple.mouse.tapBehavior -int 1
defaults write com.apple.universalaccess mouseDriverCursorSize -float 2.5
defaults write -g com.apple.mouse.scaling -float 1
defaults write -g com.apple.mouse.linear -bool true

echo "✓"

#!/bin/bash

# === Finder ===

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true


# === Dock ===

# don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true


# restarting apps:
echo 'Restarting apps...'
killall Dock
killall Finder

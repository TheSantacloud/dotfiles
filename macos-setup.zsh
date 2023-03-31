#!/usr/bin/env zsh 

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "Batbook Pro"
sudo scutil --set HostName "batbookpro"
sudo scutil --set LocalHostName "batbookpro"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "batbookpro"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set highlight color to green
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1 
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en-IL" "he-IL"
defaults write NSGlobalDomain AppleLocale -string "en_IL"

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Move dock orientation to left
defaults write com.apple.dock orientation -string "left"

# Set tile size to 33
defaults write com.apple.dock tilesize -int 33

# Disable magnification on hover
defaults write com.apple.dock magnification -int 0

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

################################################################################
# Network                                                                      #
################################################################################

# modify dns resolver
echo modifying dns resolution to 1.1.1.1
networksetup -setdnsservers Wi-Fi 1.1.1.1


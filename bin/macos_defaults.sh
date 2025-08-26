
#!/usr/bin/env bash
set -euo pipefail

defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder || true

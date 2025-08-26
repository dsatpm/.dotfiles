#!/usr/bin/env zsh
set -euo pipefail

echo "Installing Homebrew packages via Brewfile..."
brew bundle --file="$HOME/.config/dotfiles/Brewfile"

echo "Setting up Node (fnm + Corepack)..."
~/.config/dotfiles/scripts/node-setup.zsh

echo "Installing Composer globals (drush, standards, phpstan extensions)..."
~/.config/dotfiles/scripts/composer-global.sh

echo "Linking .zshrc and editor settings..."
ln -sf "$HOME/.config/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.config/dotfiles/node/.editorconfig" "$HOME/.editorconfig"

echo "Done. Open a new shell or run: source ~/.zshrc"

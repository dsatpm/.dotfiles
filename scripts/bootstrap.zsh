#!/usr/bin/env zsh
set -euo pipefail

echo "Installing Homebrew packages via Brewfile..."
brew bundle --file="$HOME/.dotfiles/Brewfile"

echo "Setting up Node (fnm + Corepack)..."
~/.dotfiles/scripts/node-setup.zsh

echo "Installing Composer globals (drush, standards, phpstan extensions)..."
~/.dotfiles/scripts/composer-global.sh

echo "Linking .zshrc and editor settings..."
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/node/.editorconfig" "$HOME/.editorconfig"

echo "Done. Open a new shell or run: source ~/.zshrc"

#!/usr/bin/env zsh
set -euo pipefail

echo "Installing Homebrew packages via Brewfile..."
brew bundle --file="$HOME/dotfiles/Brewfile"

echo "Setting up Node (fnm + Corepack)..."
~/dotfiles/scripts/node-setup.zsh

echo "Installing Composer globals (drush, standards, phpstan extensions)..."
~/dotfiles/scripts/composer-global.sh

echo "Linking .zshrc and editor settings..."
ln -sf "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/dotfiles/node/.editorconfig" "$HOME/.editorconfig"

echo "Setting up macOS_defaults and updating system applications (Composer, Node, Homebrew)..."
~/dotfiles/scripts/macos_defaults.zsh
~/dotfiles/scripts/update.sh

echo "Stowing dotfiles to proper directories..."
stow "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
stow "$HOME/dotfiles/git" "$HOME/.gitignore_global"
stow "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
stow "$HOME/dotfiles/ssh" "$HOME/.ssh"
stow "$HOME/dotfiles/starship" "$HOME/.config/starship"
stow "$HOME/dotfiles/tmux" "$HOME/.config/tmux"

echo "Done. Open a new shell or run: source ~/.zshrc"

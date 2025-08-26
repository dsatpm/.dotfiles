#!/usr/bin/env zsh
set -euo pipefail

# Install Homebrew
echo "Installing Homebrew packages via Brewfile..."
brew bundle --file="$HOME/dotfiles/Brewfile"

# Install Node
echo "Setting up Node (fnm + Corepack)..."
~/dotfiles/scripts/node-setup.zsh

# Install Composer globals
echo "Installing Composer globals (drush, standards, phpstan extensions)..."
~/dotfiles/scripts/composer-global.sh

# Install macOS defaults and update system applications
echo "Setting up macOS_defaults and updating system applications (Composer, Node, Homebrew)..."
~/dotfiles/scripts/macos_defaults.zsh
~/dotfiles/scripts/update.sh

# Stow dotfiles
echo "Stowing dotfiles to proper directories..."
stow "$HOME/dotfiles/git" "$HOME/.gitignore_global"
stow "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
stow "$HOME/dotfiles/ssh" "$HOME/.ssh"
stow "$HOME/dotfiles/starship" "$HOME/.config/starship"
stow "$HOME/dotfiles/tmux" "$HOME/.config/tmux"
stow "$HOME/dotfiles/zsh" "$HOME/.zshrc"

# Copy Node editor settings
cp "$HOME/dotfiles/node/.editorconfig" "$HOME/.editorconfig"
cp "$HOME/dotfiles/node/.prettierrc" "$HOME/.prettierrc"
cp "$HOME/dotfiles/node/.eslintrc.cjs" "$HOME/.eslintrc.cjs"

echo "Done. Open a new shell or run: reset && source ~/.zshrc"

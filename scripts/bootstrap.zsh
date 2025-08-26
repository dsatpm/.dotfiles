#!/usr/bin/env zsh
set -euo pipefail

# Install Homebrew
echo "Installing Homebrew packages via Brewfile..."
brew bundle --file="$HOME/dotfiles/Brewfile"

# Install Node
echo "Setting up Node (fnm + Corepack)..."
bash ~/dotfiles/scripts/node-setup.zsh

# Install Composer globals
echo "Installing Composer globals (drush, standards, phpstan extensions)..."
bash ~/dotfiles/scripts/composer-global.sh

# Install macOS defaults and update system applications
echo "Setting up macOS_defaults and updating system applications (Composer, Node, Homebrew)..."
bash ~/dotfiles/bin/macos_defaults.sh
bash ~/dotfiles/bin/update.sh

# Stow dotfiles
echo "Stowing dotfiles to proper directories..."
stow -v --dir="$HOME/dotfiles/git" --target="$HOME"/ .gitignore_global
stow -v --dir="$HOME/dotfiles/nvim" --target="$HOME"/.config/nvim .config/nvim
stow -v --dir="$HOME/dotfiles/ssh" --target="$HOME"/.ssh .ssh
stow -v --dir="$HOME/dotfiles/starship" --target="$HOME"/.config/starship .config/starship
stow -v --dir="$HOME/dotfiles/tmux" --target="$HOME"/.config/tmux .config/tmux
stow -v --dir="$HOME/dotfiles/zsh" --target="$HOME"/.zshrc .zshrc

# Copy Node editor settings
cp "$HOME/dotfiles/node/.editorconfig" "$HOME/.editorconfig"
cp "$HOME/dotfiles/node/.prettierrc" "$HOME/.prettierrc"
cp "$HOME/dotfiles/node/.eslintrc.cjs" "$HOME/.eslintrc.cjs"

echo "Done. Open a new shell or run: reset && source ~/.zshrc"

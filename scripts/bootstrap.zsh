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
# Use the repo root as the stow directory and stow each package name.
# This lets packages that contain nested paths like ".config/nvim" or ".ssh/config"
# be linked into $HOME in the correct locations.
DOTFILES_DIR="$HOME/dotfiles"
PACKAGES=(git nvim ssh starship tmux zsh)
BACKUP_DIR="$HOME/dotfiles-backups/$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Robust backup: move any existing non-stow-owned targets that would conflict.
# For each package, walk its contents and back up the corresponding path in $HOME
backup_package_contents() {
  local pkg pkg_dir src rel dest dest_target
  for pkg in "${PACKAGES[@]}"; do
    pkg_dir="$DOTFILES_DIR/$pkg"
    [ -d "$pkg_dir" ] || continue

    # find all files/dirs inside the package (skip the package root itself)
    while IFS= read -r -d '' src; do
      rel="${src#$pkg_dir/}"          # path relative to package dir
      dest="$HOME/$rel"

      # nothing to do if target doesn't exist
      if [ ! -e "$dest" ] && [ ! -L "$dest" ]; then
        continue
      fi

      # skip if it's already a symlink pointing into the dotfiles repo
      if [ -L "$dest" ]; then
        dest_target="$(readlink "$dest")" || dest_target=""
        case "$dest_target" in
          "$DOTFILES_DIR"/*|*/dotfiles/*)
            echo "Skipping $dest (already symlinked to dotfiles)"
            continue
            ;;
        esac
      fi

      # ensure backup parent exists and move the existing target
      mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
      echo "Backing up existing target: $dest -> $BACKUP_DIR/$rel"
      mv -v "$dest" "$BACKUP_DIR/$rel" || { echo "Failed to back up $dest"; exit 1; }
    done < <(find "$pkg_dir" -mindepth 1 -print0)
  done
}
backup_package_contents

# Run stow after clearing conflicts
stow -v --dir="$DOTFILES_DIR" --target="$HOME" "${PACKAGES[@]}"

# Copy Node editor settings
ln -sf "$HOME/dotfiles/node/.editorconfig" "$HOME/.editorconfig"
ln -sf "$HOME/dotfiles/node/.prettierrc" "$HOME/.prettierrc"
ln -sf "$HOME/dotfiles/node/.eslintrc.cjs" "$HOME/.eslintrc.cjs"

echo "Done. Open a new shell or run: reset && source ~/.zshrc"

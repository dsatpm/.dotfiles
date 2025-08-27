
#!/usr/bin/env bash
set -euo pipefail

is_macos(){ [[ "$(uname -s)" == "Darwin" ]]; }
is_linux(){ [[ "$(uname -s)" == "Linux" ]]; }

if is_macos; then
  if ! command -v brew >/dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  brew bundle --file=./Brewfile
elif is_linux && command -v apt >/dev/null; then
  sudo apt update
  sudo apt install -y git stow zsh tmux fzf ripgrep fd-find jq neovim direnv curl wget gpg
  if command -v fdfind >/dev/null && ! command -v fd >/dev/null; then
    sudo update-alternatives --install /usr/local/bin/fd fd "$(command -v fdfind)" 10 || true
  fi
else
  echo "Install: git stow zsh tmux fzf ripgrep fd jq neovim direnv curl wget gpg"
fi

# Antidote + Starship
[[ -d "$HOME/.antidote" ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"
command -v starship >/dev/null || curl -fsSL https://starship.rs/install.sh | bash -s -- -y

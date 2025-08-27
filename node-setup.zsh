#!/usr/bin/env zsh
set -euo pipefail

eval "$(/opt/homebrew/bin/brew shellenv)"
export FNM_DIR="$HOME/.fnm"
eval "$(fnm env --use-on-cd)"

# Install latest LTS and set default
fnm install --lts
fnm default lts-latest

# Enable Corepack (manages yarn/pnpm versions)
corepack enable

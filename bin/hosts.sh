#!/usr/bin/env bash
set -euo pipefail

ENV="${1:-local}"
FILE="$HOME/.dotfiles/envs/hosts.$ENV"

[[ -f "$FILE" ]] || { echo "Missing $FILE"; exit 1; }

sudo cp /etc/hosts /etc/hosts.bak.$(date +%s)
sudo sed -i.bak '/### DOTFILES HOSTS START/,/### DOTFILES HOSTS END/d' /etc/hosts

{
  echo "### DOTFILES HOSTS START ($ENV)"
  cat "$FILE"
  echo "### DOTFILES HOSTS END"
} | sudo tee -a /etc/hosts >/dev/null

echo "Applied hosts for $ENV"

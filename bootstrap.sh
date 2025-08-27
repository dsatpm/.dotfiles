
#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

command -v stow >/dev/null || { echo "Install stow first"; exit 1; }

for pkg in $(ls -1 stow); do
  echo "Stowing $pkg"
  stow --no-folding --target="$HOME" --dir=./stow "$pkg"
done

echo "Done. Open a new shell."

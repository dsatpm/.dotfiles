
#!/usr/bin/env bash
set -euo pipefail

if command -v brew >/dev/null; then brew update && brew upgrade && brew cleanup; fi
if command -v antidote >/dev/null; then antidote update; fi
if command -v nvim >/dev/null; then nvim +Lazy! sync +qall || true; fi
if command -v npm >/dev/null; then npm -g update || true; fi
if command -v composer >/dev/null; then composer self-update || true; fi

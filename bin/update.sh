
#!/usr/bin/env bash
set -euo pipefail

command -v brew >/dev/null && brew update && brew upgrade && brew cleanup
command -v antidote >/dev/null && antidote update
command -v nvim >/dev/null && nvim +Lazy! sync +qall || true
command -v npm  >/dev/null && npm -g update || true
command -v composer >/dev/null && composer self-update || true

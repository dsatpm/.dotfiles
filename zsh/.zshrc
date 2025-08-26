# Homebrew (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Composer (global bin (support legacy + XDG)
export PATH="$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:$PATH"

# fnm (Node Version Manager) + Corepack
export FNM_DIR="$HOME/.fnm"
eval "$(fnm env --use-on-cd)"
# Corepack (yarn/pnpm) will be enabled in scripts/node-setup.zsh

# Prefer in-container tooling when using Lando
export WP_CLI_CACHE_DIR="$HOME/.wp-cli/cache"

# Aliases
for f in "$HOME/.config/dotfiles/zsh/aliases.*.zsh"; do
	[ -r "$f" ] && . "$f"
done

# Starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

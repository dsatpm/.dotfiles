#!/usr/bin/env zsh

# ──────────────────────────────────────────────────────
#  Homebrew (Apple Silicon) and core PATHs
# ──────────────────────────────────────────────────────
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Core PATHs
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.lando/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:$PATH"

# Language/runtime specific PATHs if present
[ -x /usr/local/bin/php ] && export PATH="/usr/local/bin/php:$PATH"
[ -x /usr/local/bin/python3 ] && export PATH="$PATH:/usr/local/bin/python3"

# ──────────────────────────────────────────────────────
#  Environment variables
# ──────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
export WP_CLI_CACHE_DIR="$HOME/.wp-cli/cache"
export EDITOR='nvim'
export PAGER='less -R'

# ──────────────────────────────────────────────────────
#  Node toolchains
# ──────────────────────────────────────────────────────
# Prefer fnm; fall back to nvm; support Volta if present
if command -v fnm >/dev/null 2>&1; then
  export FNM_DIR="$HOME/.fnm"
  eval "$(fnm env --use-on-cd)"
elif [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  . "$HOME/.nvm/nvm.sh"
  [ -s "$HOME/.nvm/bash_completion" ] && . "$HOME/.nvm/bash_completion"
fi
if [ -d "$HOME/.volta" ]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# ──────────────────────────────────────────────────────
#  Oh My Zsh and plugins
# ──────────────────────────────────────────────────────
plugins=(
  git
  docker
  lando
  zsh-syntax-highlighting
)
[ -s "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Brew completions in fpath (let OMZ manage compinit)
if command -v brew >/dev/null 2>&1; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# ──────────────────────────────────────────────────────
#  Prompt / Shell enhancements
# ──────────────────────────────────────────────────────
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
if command -v direnv >/dev/null 2>&1; then
  export DIRENV_LOG_FORMAT=""
  eval "$(direnv hook zsh)"
fi

# fzf defaults (requires ripgrep)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules,vendor,.cache}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# ──────────────────────────────────────────────────────
#  Aliases & customizations
# ──────────────────────────────────────────────────────

# General aliases
alias ls='eza -al --group-directories-first'
alias cat='bat -pp'
alias grep='rg --color=always'
alias reset='source ~/.zshrc'

# Drupal aliases
alias nukeit='lando poweroff && docker system prune -a --volumes && rm -rf ~/.lando/cache'
alias novendor='rm -rf vendor web/core web/themes/contrib web/modules/contrib web/libraries web/profiles/contrib'
alias cleanatdove='rm -rf composer.lock vendor web/core web/themes/contrib web/modules/contrib web/libraries web/profiles/contrib web/themes/custom/atdove/node_modules web/themes/custom/atdove/build'
alias cleancowlitz='rm -rf composer.lock vendor web/core web/themes/contrib web/modules/contrib web/libraries web/profiles/contrib web/themes/custom/cowlitz_bootstrap/node_modules web/themes/custom/cowlitz_bootstrap/build'

# Load any dotfiles-managed alias sets
for f in "$HOME/.config/dotfiles/zsh/aliases."*.zsh; do
  [ -r "$f" ] && . "$f"
done

# Load any Oh My Zsh custom aliases
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/aliases" ]]; then
  for file in "$ZSH_CUSTOM/aliases/"*.zsh; do
    [ -r "$file" ] && source "$file"
  done
fi

# ──────────────────────────────────────────────────────
#  Lando‑Plugin Configuration
# ──────────────────────────────────────────────────────
export LANDO_ZSH_SITES_DIRECTORY="$HOME/dev/helloworld"
export LANDO_ZSH_CONFIG_FILE=".lando.yml"
export LANDO_ZSH_WRAPPED_COMMANDS="mysql php composer test artisan drush gulp npm wp"

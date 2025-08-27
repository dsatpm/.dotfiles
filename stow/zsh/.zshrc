
export ZDOTDIR="$HOME"

# Homebrew (Apple Silicon)
[ -d /opt/homebrew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Antidote
source "$HOME/.antidote/antidote.zsh"
antidote load <<'PLUGINS'
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
zsh-users/zsh-syntax-highlighting
romkatv/zsh-defer
PLUGINS

# Prompt
eval "$(starship init zsh)"

# Direnv (silent)
export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"

# Node (Volta)
export VOLTA_HOME="$HOME/.volta"
[ -d "$VOLTA_HOME" ] && export PATH="$VOLTA_HOME/bin:$PATH"

# Make fzf use fd (lighter than ripgrep for file lists)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude node_modules --exclude vendor --exclude .cache'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export EDITOR="nvim"
export PAGER="less -R"

alias ls='eza -al --group-directories-first'
alias cat='bat -pp'
alias grep='rg'

autoload -Uz compinit && compinit -C
setopt correct nocaseglob hist_ignore_all_dups share_history

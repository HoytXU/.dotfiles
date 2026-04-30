# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─────────────────────────────────────────────────────────────
# 🚀 Basic Setup
# ─────────────────────────────────────────────────────────────

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
export EDITOR="nvim"
export PATH="$HOME/bin:$PATH"

# ─────────────────────────────────────────────────────────────
# 🔌 Plugins
# ─────────────────────────────────────────────────────────────

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# ─────────────────────────────────────────────────────────────
# ⚙️ Zsh Options
# ─────────────────────────────────────────────────────────────

setopt autocd              # Just type folder name to cd into it
setopt glob_complete       # Better tab completion
setopt correct             # Auto-correct mistyped commands
setopt append_history      # Don’t overwrite history
setopt hist_ignore_dups    # Don't record consecutive duplicate commands
setopt hist_ignore_space   # Don't record commands starting with a space

# ─────────────────────────────────────────────────────────────
# 📜 History Settings
# ─────────────────────────────────────────────────────────────

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# ─────────────────────────────────────────────────────────────
# 🎨 Prompt & Colors
# ─────────────────────────────────────────────────────────────

# PROMPT='%F{cyan}%n@%m %F{green}%~ %F{yellow}%% %f'
autoload -U colors && colors

# ─────────────────────────────────────────────────────────────
# 🔁 Aliases
# ─────────────────────────────────────────────────────────────

# Git
alias gs='git status'
alias gaa='git add .'
alias ga='git add'
alias gco='git checkout'
alias gc='git commit'
alias gpl='git pull'
alias gp='git push'
alias gf='git fetch'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Editors
alias nv='nvim'
alias v='vim'

# Utils
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# ─────────────────────────────────────────────────────────────
# 🛠️ Custom Functions
# ─────────────────────────────────────────────────────────────

mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ─────────────────────────────────────────────────────────────
# 🔄 Oh My Zsh Update Settings
# ─────────────────────────────────────────────────────────────

DISABLE_AUTO_UPDATE="false"
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' frequency 13

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Shared environment (secrets, conda, PATH, NVM, bun) — also sourced by ~/.bashrc
[ -f "$HOME/.dotfiles/shell/env.sh" ] && . "$HOME/.dotfiles/shell/env.sh"


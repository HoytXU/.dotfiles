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
# ⚙️ Zsh Options & History
# ─────────────────────────────────────────────────────────────

[ -f "$HOME/.dotfiles/shell/zsh/options.zsh" ] && . "$HOME/.dotfiles/shell/zsh/options.zsh"

# ─────────────────────────────────────────────────────────────
# 🎨 Prompt & Colors
# ─────────────────────────────────────────────────────────────

# PROMPT='%F{cyan}%n@%m %F{green}%~ %F{yellow}%% %f'
autoload -U colors && colors

# ─────────────────────────────────────────────────────────────
# 🔁 Aliases
# ─────────────────────────────────────────────────────────────

[ -f "$HOME/.dotfiles/shell/zsh/aliases.zsh" ] && . "$HOME/.dotfiles/shell/zsh/aliases.zsh"

# ─────────────────────────────────────────────────────────────
# 🛠️ Custom Functions
# ─────────────────────────────────────────────────────────────

[ -f "$HOME/.dotfiles/shell/zsh/functions.zsh" ] && . "$HOME/.dotfiles/shell/zsh/functions.zsh"

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


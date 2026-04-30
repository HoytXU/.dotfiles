# Zsh options & history settings.
# Sourced by ~/.zshrc.

# ─────────────────────────────────────────────────────────────
# ⚙️ Behavior
# ─────────────────────────────────────────────────────────────

setopt autocd              # Just type folder name to cd into it
setopt glob_complete       # Better tab completion
setopt correct             # Auto-correct mistyped commands

# ─────────────────────────────────────────────────────────────
# 📜 History
# ─────────────────────────────────────────────────────────────

setopt append_history      # Don’t overwrite history
setopt hist_ignore_dups    # Don't record consecutive duplicate commands
setopt hist_ignore_space   # Don't record commands starting with a space

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

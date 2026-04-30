# Shared interactive shell environment.
# Sourced by both ~/.bashrc and ~/.zshrc. Keep POSIX-compatible:
# no bash-isms or zsh-isms in this file.

[ -f "$HOME/.secrets" ] && . "$HOME/.secrets"

# >>> conda initialize >>>
# Originally managed by 'conda init'. Moved here for shell-agnostic loading.
# Note: re-running `conda init` will write a fresh block back into ~/.bashrc
# or ~/.zshrc; if that happens, fold it back into this file and remove the
# duplicate from the rc file.
if [ -n "$ZSH_VERSION" ]; then
    _conda_shell="zsh"
else
    _conda_shell="bash"
fi
__conda_setup="$('/home/paradox/miniconda3/bin/conda' "shell.$_conda_shell" 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/paradox/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/paradox/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/paradox/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup _conda_shell
# <<< conda initialize <<<

export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

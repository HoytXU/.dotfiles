# Zsh custom functions.
# Sourced by ~/.zshrc.

# Make a directory then cd into it.
mkcd() {
  mkdir -p "$1" && cd "$1"
}

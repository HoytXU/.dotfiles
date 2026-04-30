# Conventions

A short reference for how this dotfiles repo is organized and where to
put new configuration. Pair this with [`README.md`](./README.md) (which
covers install and bootstrap).

## Shell load order

Each shell reads a specific set of files at startup. This repo manages
the **interactive** rc files only.

| File              | When read                  | Managed here? |
|-------------------|----------------------------|---------------|
| `~/.profile`      | POSIX login shells         | No            |
| `~/.bash_profile` | bash login shells          | No            |
| `~/.zprofile`     | zsh login shells           | No            |
| `~/.bashrc`       | bash interactive shells    | **Yes**       |
| `~/.zshrc`        | zsh interactive shells     | **Yes**       |
| `~/.bash_logout`  | bash logout                | No            |
| `~/.zlogout`      | zsh logout                 | No            |

Both `~/.bashrc` and `~/.zshrc` source [`shell/env.sh`](./shell/env.sh)
near the end. That is the **single shared layer** for things both
shells need: `~/.secrets` source, conda init, and PATH/init for
`~/.local/bin`, opencode, NVM, and bun.

Private values live in `~/.secrets` (NOT in this repo) and are sourced
by `env.sh` if present.

## Zsh layout

`~/.zshrc` is intentionally thin. The bits that must stay inline (load
order matters):

- powerlevel10k instant-prompt block at the very top
- `$ZSH` / theme / `EDITOR` / `PATH` exports
- `plugins=(...)` array and `source $ZSH/oh-my-zsh.sh`
- `lesspipe` / `dircolors` init
- trailing sources of `~/.p10k.zsh` and `shell/env.sh`

Everything else is split into [`shell/zsh/`](./shell/zsh/):

| File                                          | Contains                              |
|-----------------------------------------------|---------------------------------------|
| [`shell/zsh/options.zsh`](./shell/zsh/options.zsh)     | `setopt` flags, history settings   |
| [`shell/zsh/aliases.zsh`](./shell/zsh/aliases.zsh)     | git / safety / editors / utils     |
| [`shell/zsh/functions.zsh`](./shell/zsh/functions.zsh) | `mkcd` and other custom functions  |

## Where new things go

| You want to add...                  | Put it in                                       |
|-------------------------------------|-------------------------------------------------|
| PATH entry both shells need         | `shell/env.sh`                                  |
| Tool init both shells need          | `shell/env.sh`                                  |
| Zsh alias                           | `shell/zsh/aliases.zsh`                         |
| Zsh function                        | `shell/zsh/functions.zsh`                       |
| Zsh option / history setting        | `shell/zsh/options.zsh`                         |
| Bash-only alias / function          | `shell/.bashrc` (kept whole, not split)         |
| Token / API key / private host      | `~/.secrets` (outside this repo)                |
| New symlinked config                | Add entry to `install.conf.yaml`, run `./install` |
| Runtime cache / generated state     | Nowhere — add a `.gitignore` rule instead       |

## Performance note

Avoid running expensive commands during shell startup (network calls,
long subshells, large file scans). They run on every new terminal.
Prefer lazy-loading (e.g. NVM is sourced but doesn't auto-load Node)
and cache results of slow commands when possible.

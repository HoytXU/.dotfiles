# Dotfiles

A version-controlled, reproducible home directory for Linux development.
Bash, Zsh, Vim, Neovim, tmux, WezTerm — all symlinked into `~` from a
single git repo using [dotbot](https://github.com/anishathalye/dotbot).

This README is written for someone who has never set up a dotfiles
repository before. If you already know what dotfiles, dotbot, and git
submodules are, jump straight to [Quick start](#quick-start).

## Table of contents

- [What are "dotfiles"?](#what-are-dotfiles)
- [Why put them in git?](#why-put-them-in-git)
- [What this repo gives you](#what-this-repo-gives-you)
- [The mental model](#the-mental-model)
- [Quick start](#quick-start)
- [First-run checklist](#first-run-checklist)
- [The shell layer in depth](#the-shell-layer-in-depth)
- [Where new things go](#where-new-things-go)
- [Worked example: add a Zsh alias](#worked-example-add-a-zsh-alias)
- [Worked example: add a new symlinked config](#worked-example-add-a-new-symlinked-config)
- [Updating and day-to-day operations](#updating-and-day-to-day-operations)
- [Submodules: what they are and how this repo uses them](#submodules-what-they-are-and-how-this-repo-uses-them)
- [Conventions and gotchas](#conventions-and-gotchas)
- [Repository layout](#repository-layout)
- [Troubleshooting](#troubleshooting)
- [Glossary](#glossary)
- [Credits](#credits)

---

## What are "dotfiles"?

On Linux and macOS, configuration files in your home directory typically
start with a dot (`.`), which makes them hidden by default in `ls`.
Examples you've probably already met:

| File             | Used by                                              |
|------------------|------------------------------------------------------|
| `~/.bashrc`      | Bash, every time you open an interactive bash shell  |
| `~/.zshrc`       | Zsh, every time you open an interactive zsh shell    |
| `~/.vimrc`       | Vim startup                                          |
| `~/.tmux.conf`   | tmux startup                                         |
| `~/.gitconfig`   | git's user-level configuration                       |

Collectively these are called **dotfiles** — your personal preferences
for the tools you use. They're how you tell each tool: "this is how *I*
want you to behave."

When you reinstall your OS, switch laptops, or set up a new VM, container,
or WSL instance, recreating all this configuration by hand is tedious and
easy to get wrong. That is the problem this repo solves.

## Why put them in git?

Three reasons, in priority order:

1. **Reproducibility.** A new machine becomes "your" machine after one
   `./install`. No "wait, what was that alias I always used?"
2. **History.** When you change a config and your shell breaks the next
   day, `git log -p` tells you exactly what changed.
3. **Sharing.** You can publish your setup, copy it to a server, or hand
   a snippet to a colleague.

The trade-off is one-time learning of the conventions in this repository.
That learning is what the rest of this README is for.

## What this repo gives you

After running `./install` on a fresh Linux box you get:

- A configured **Bash** and **Zsh** sharing one environment layer
  (PATH, conda, NVM, bun, secrets) plus shell-specific niceties:
  autosuggestions, syntax highlighting, and the [Powerlevel10k] prompt.
- **Vim** with a curated plugin set (NerdTree, CtrlP, easymotion,
  surround, ack, colorschemes).
- **Neovim** with a [lazy.nvim]-managed plugin set (LSP, completion,
  nvim-tree, treesitter, Catppuccin theme).
- **tmux** and **WezTerm** with sensible defaults.
- A pattern for **secrets** that keeps them out of this repo but
  available in every shell.

[Powerlevel10k]: https://github.com/romkatv/powerlevel10k
[lazy.nvim]: https://github.com/folke/lazy.nvim

## The mental model

This repo does **not** copy config files into your home directory. It
creates **symbolic links** (`ln -s`) that point from `~/whatever` to the
real file inside this repo. Editing `~/.zshrc` is editing
`~/.dotfiles/shell/.zshrc` — there is only one source of truth, and your
edits are automatically visible to git.

After install, your home directory looks roughly like this:

```
~/                                  ~/.dotfiles/
├── .zshrc        ──── symlink ───> shell/.zshrc
├── .bashrc       ──── symlink ───> shell/.bashrc
├── .vimrc        ──── symlink ───> shell/.vimrc
├── .vim/         ──── symlink ───> shell/.vim/
├── .tmux.conf    ──── symlink ───> shell/.tmux.conf
├── .oh-my-zsh/   ──── symlink ───> shell/.oh-my-zsh/
├── .config/nvim/ ──── symlink ───> shell/.config/nvim/
├── .p10k.zsh     ──── symlink ───> shell/.p10k.zsh
├── .wezterm.lua  ──── symlink ───> shell/.wezterm.lua
└── .secrets         ← (real file, NOT in this repo, NOT symlinked)
```

The symlinks themselves are managed by **dotbot** — a tiny tool (which is
itself a submodule of this repo) that reads
[`install.conf.yaml`](./install.conf.yaml) and creates the links
declaratively. Re-running `./install` is **idempotent**: it re-checks
every symlink and is safe to run any time.

## Quick start

### Prerequisites

- Linux (Ubuntu 20.04+ recommended; other Debian-likes should also work)
- `git`, `curl`, `wget`, and a working internet connection

### Option A: Full system bootstrap

If this is a brand-new box and you're OK with a script installing zsh,
neovim (unstable), tmux, npm, tldr, and Miniconda for you:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/HoytXU/.dotfile/master/setup.sh)
```

`setup.sh` will, in order:

1. Verify you're on Linux.
2. Switch apt to a TUNA mirror if `archive.ubuntu.com` is unreachable
   (helpful from China).
3. `apt update && upgrade`.
4. Add the neovim unstable PPA and install neovim.
5. `apt install` zsh, tldr, npm, curl, git, wget, tmux, htop.
6. Clone this repo to `~/.dotfiles`, init submodules, run `./install`.
7. Install Miniconda to `~/miniconda3` if it isn't already there.

### Option B: Dotfiles only (manual)

If you already have the OS-level packages you want and just want this
repo's configurations:

```bash
git clone https://github.com/HoytXU/.dotfile.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive   # fetches dotbot, plugins, themes
./install                                  # creates the symlinks
```

The clone path **must** be `~/.dotfiles`. See
[Conventions and gotchas](#the-repo-must-live-at-dotfiles) for why.

## First-run checklist

After `./install` succeeds, do these once:

1. **Make zsh your default shell** (if it isn't):
   ```bash
   chsh -s "$(which zsh)"
   ```
   Log out and back in for the change to take effect.

2. **Configure the Powerlevel10k prompt**:
   ```bash
   p10k configure
   ```
   This walks you through prompt style choices and writes `~/.p10k.zsh`.
   Because that path is a symlink into this repo, the wizard ends up
   editing `shell/.p10k.zsh` directly. Commit the result if you want to
   version your prompt style.

3. **Open Neovim once** so [lazy.nvim] can install plugins:
   ```bash
   nvim
   ```
   Then `:Lazy sync` if any plugin shows as missing.

4. **Create `~/.secrets`** (only if you have any):
   ```bash
   cat > ~/.secrets <<'EOF'
   export GITHUB_TOKEN="..."
   export OPENAI_API_KEY="..."
   EOF
   chmod 600 ~/.secrets
   ```
   `shell/env.sh` automatically sources `~/.secrets` if it exists, so any
   `export` you put there is available in both bash and zsh.

## The shell layer in depth

The shell layer is the heart of this repo and the most opinion-laden.
Worth understanding.

### Which file does what shell read?

| File              | When the shell reads it     | Managed in this repo? |
|-------------------|-----------------------------|-----------------------|
| `~/.profile`      | POSIX login shells          | No                    |
| `~/.bash_profile` | Bash login shells           | No                    |
| `~/.zprofile`     | Zsh login shells            | No                    |
| `~/.bashrc`       | Bash interactive shells     | **Yes**               |
| `~/.zshrc`        | Zsh interactive shells      | **Yes**               |
| `~/.bash_logout`  | Bash logout                 | No                    |
| `~/.zlogout`      | Zsh logout                  | No                    |

This repo only manages **interactive rc files**. Login-shell files
(`*profile`) are intentionally left untouched — they tend to be
system-managed and editing them invites surprise breakage on upgrades.

### The shared layer: `shell/env.sh`

A common dotfiles trap is to maintain two near-identical copies of shell
setup: one for bash, one for zsh. To avoid that, this repo puts
everything *both* shells need into one POSIX-compatible script,
[`shell/env.sh`](./shell/env.sh):

- Source `~/.secrets` if it exists.
- Initialize Conda (using the right shell hook for bash vs zsh).
- Append `~/.local/bin`, `~/.opencode/bin`, NVM, and bun to `PATH`.

Both `~/.bashrc` and `~/.zshrc` source this file near the end. Result:
one place to update PATH or add a tool's init line.

```
                ┌────────────────────────────┐
~/.bashrc ────► │                            │ ◄──── ~/.zshrc
                │       shell/env.sh         │
                │  (secrets, conda, PATH,    │
                │   NVM, bun — POSIX only)   │
                └────────────────────────────┘
```

`env.sh` is **not** symlinked. Both rc files reference it via a fixed
path:

```bash
[ -f "$HOME/.dotfiles/shell/env.sh" ] && . "$HOME/.dotfiles/shell/env.sh"
```

That fixed path is why the repo must live at `~/.dotfiles`.

### Zsh's modular layout

`~/.zshrc` is intentionally thin — it's just an orchestrator. The
substantive content lives in `shell/zsh/`:

| File                         | Contains                                |
|------------------------------|-----------------------------------------|
| `shell/zsh/options.zsh`      | `setopt` flags, history settings        |
| `shell/zsh/aliases.zsh`      | git / safety / editors / utility aliases|
| `shell/zsh/functions.zsh`    | Custom shell functions (e.g. `mkcd`)    |

Some things stay inline in `.zshrc` because order matters:

- The Powerlevel10k **instant-prompt** block at the very top.
- `$ZSH`, theme, `EDITOR`, `PATH` exports.
- `plugins=(...)` array and `source $ZSH/oh-my-zsh.sh`.
- `lesspipe` / `dircolors` initialization.
- Trailing source of `~/.p10k.zsh` and `shell/env.sh`.

Bash is **not** split into modules — `shell/.bashrc` is small and mostly
upstream Ubuntu boilerplate plus the `env.sh` source.

### Visualizing the load chain

A new zsh terminal does roughly this:

```
zsh starts
  │
  ├─► reads ~/.zshrc  (symlink → shell/.zshrc)
  │     │
  │     ├─ p10k instant prompt
  │     ├─ exports + plugins + oh-my-zsh
  │     ├─ source shell/zsh/options.zsh
  │     ├─ source shell/zsh/aliases.zsh
  │     ├─ source shell/zsh/functions.zsh
  │     └─ source shell/env.sh
  │            │
  │            ├─ source ~/.secrets (if present)
  │            ├─ conda init (zsh hook)
  │            └─ PATH += ~/.local/bin, opencode, NVM, bun
  │
  ▼
prompt is ready
```

## Where new things go

You will, sooner or later, want to add a new alias, a new PATH entry, or
a new tool. Here's the cheat sheet:

| You want to add…                  | Put it in                                       |
|-----------------------------------|-------------------------------------------------|
| PATH entry both shells need       | `shell/env.sh`                                  |
| Tool init both shells need        | `shell/env.sh`                                  |
| Zsh alias                         | `shell/zsh/aliases.zsh`                         |
| Zsh function                      | `shell/zsh/functions.zsh`                       |
| Zsh option / history setting      | `shell/zsh/options.zsh`                         |
| Bash-only alias / function        | `shell/.bashrc` (kept whole, not split)         |
| Token / API key / private host    | `~/.secrets` (outside this repo)                |
| New symlinked config              | Add entry to `install.conf.yaml`, run `./install` |
| Runtime cache / generated state   | Nowhere — add a `.gitignore` rule instead       |

The point of this table is: **don't pile everything into `.zshrc`**.
Aliases go in `aliases.zsh`. Shell-agnostic env goes in `env.sh`.
Future-you will thank you when one of those modules grows large enough
to need attention of its own.

## Worked example: add a Zsh alias

You want `gba` to mean `git branch -a`. From scratch:

```bash
cd ~/.dotfiles

# 1. Add the alias to the appropriate module
echo "alias gba='git branch -a'" >> shell/zsh/aliases.zsh

# 2. Reload it in your current shell (no need to restart)
source shell/zsh/aliases.zsh

# 3. Verify
type gba
# gba is an alias for git branch -a

# 4. Commit it
git add shell/zsh/aliases.zsh
git commit -m "feat(zsh): Add gba alias for git branch -a"
```

Notice what you did **not** do: you did not edit `.zshrc`, and you did
not run `./install`. No new symlinks were needed — `aliases.zsh` is
already sourced by `.zshrc`. The change is one file deep.

## Worked example: add a new symlinked config

Suppose you want to start versioning `~/.config/btop/btop.conf` (the
[btop] system monitor's config).

[btop]: https://github.com/aristocratos/btop

```bash
cd ~/.dotfiles

# 1. Pull the existing config into the repo (or create an empty one)
mkdir -p shell/.config/btop
mv ~/.config/btop/btop.conf shell/.config/btop/btop.conf
# If you don't have one yet, just: touch shell/.config/btop/btop.conf
```

Edit [`install.conf.yaml`](./install.conf.yaml) and add an entry under
the `link:` map:

```yaml
- link:
    ~/.bashrc: shell/.bashrc                                   # (existing)
    # ... existing entries ...
    ~/.config/btop/btop.conf: shell/.config/btop/btop.conf     # NEW
```

```bash
# 2. Run dotbot to create the symlink
./install

# 3. Verify
ls -la ~/.config/btop/btop.conf
# ... -> /home/you/.dotfiles/shell/.config/btop/btop.conf

# 4. Commit
git add install.conf.yaml shell/.config/btop/
git commit -m "feat(btop): Track btop config"
```

Now editing `~/.config/btop/btop.conf` (e.g. via btop itself) edits the
file inside this repo, and `git status` will see your changes.

## Updating and day-to-day operations

There's a [`Makefile`](./Makefile) at the repo root with the four
operations you'll actually use:

```bash
make                  # show all targets (default)
make install          # re-run dotbot to (re)create symlinks
make submodules-init  # initialize all submodules (first-time setup)
make update           # git pull --ff-only + submodule refresh + reinstall
```

Day-to-day rules of thumb:

- **You changed a config in this repo** → just save and reload the shell
  (`exec zsh`) or whatever tool. Symlinks already point here, so nothing
  else is needed.
- **You added a new file or new symlink entry** → `./install` (only if
  you also added an entry to `install.conf.yaml`).
- **You pulled new commits from remote** → `make update`.

## Submodules: what they are and how this repo uses them

A **git submodule** is, roughly, "a git repo nested inside this git
repo, pinned to one specific commit." When you clone this repo,
submodules are *empty* until you run:

```bash
git submodule update --init --recursive
```

(`make submodules-init` is a shortcut for this.)

This repo has 10 wired submodules in three functional groups:

**The dotbot tool itself**

- `dotbot/` — the symlink manager that powers `./install`.

**Vim plugin pack** (under `shell/.vim/pack/vendor/start/`)

- `ack.vim` (search) · `ctrlp.vim` (fuzzy file finder)
- `nerdtree` (file tree) · `surround.vim` (text-object surround)
- `vim-easymotion` (jump motions) · `vim-colorschemes`

**Oh-my-zsh customs** (under `shell/.oh-my-zsh/custom/`)

- `plugins/zsh-autosuggestions` (fish-like history hints)
- `plugins/zsh-syntax-highlighting` (live syntax coloring of the cmdline)
- `themes/powerlevel10k` (the prompt)

### Why submodules and not vendored copies?

- Pinning to a specific upstream commit means you can audit and upgrade
  deliberately, not by accident.
- `git submodule update --remote <path>` brings any one of them to its
  upstream `master`/`main` HEAD when you actually want to upgrade.
- Diffs in this repo stay tiny: a submodule pin is one line; an upgrade
  shows up as a change in commit hash, not thousands of plugin files.

### Why is `shell/.oh-my-zsh/` itself NOT a submodule?

Because nested submodules don't compose cleanly — a submodule cannot
straightforwardly contain its own submodules, and we want the
`custom/plugins/*` and `custom/themes/*` to be independent submodules.
So oh-my-zsh's *core* is a vendored snapshot (~18 MB, taken 2024-09, no
local modifications), and the `custom/` plugins/themes are real
submodules. See [Conventions and gotchas](#oh-my-zsh-is-vendored-intentionally)
for the manual refresh recipe.

## Conventions and gotchas

A short list of things that will save you confusion later.

### The repo must live at `~/.dotfiles`

Both `~/.bashrc` and `~/.zshrc` source `shell/env.sh` via the literal
path `$HOME/.dotfiles/shell/env.sh`. If you clone the repo somewhere
else, that source line will silently no-op (the `[ -f ... ]` guard hides
it), and you'll quietly lose conda init / PATH / NVM / bun. Symptom: a
fresh shell where `node`, `bun`, or `conda activate` "doesn't exist."

### Conda init caveat

Running `conda init` manually — or accepting conda's offer to run it
after a self-update — writes a managed `>>> conda initialize >>>` block
back into `~/.bashrc` and `~/.zshrc`. If that happens:

1. Diff the new managed block against the version in
   [`shell/env.sh`](./shell/env.sh).
2. Fold any new content into `env.sh`.
3. Delete the managed block from the rc file.

`setup.sh` itself no longer calls `conda init`; that is `env.sh`'s job.

### Oh-my-zsh is vendored, intentionally

`shell/.oh-my-zsh/` is a snapshot of [oh-my-zsh] at a specific date
(currently 2024-09), with no local modifications. It is **not** a git
submodule. Plugins and themes under `custom/` ARE submodules.

To refresh the snapshot manually without changing this model:

```bash
cd /tmp && git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh
cd ~/.dotfiles/shell/.oh-my-zsh
rm -rf lib plugins themes tools templates oh-my-zsh.sh *.md LICENSE.txt
cp -r /tmp/ohmyzsh/{lib,plugins,themes,tools,templates,oh-my-zsh.sh,*.md,LICENSE.txt} .
# Leave custom/ and cache/.gitkeep alone
```

[oh-my-zsh]: https://github.com/ohmyzsh/ohmyzsh

### Secrets live outside this repo

Anything sensitive (API keys, tokens, private hosts) goes in
`~/.secrets`, which is **not** tracked here. `shell/env.sh` will source
it if present:

```bash
# ~/.secrets — chmod 600
export GITHUB_TOKEN="ghp_..."
export OPENAI_API_KEY="sk-..."
```

### Performance: keep startup cheap

Every line in `.zshrc`, `.bashrc`, or anything they source runs **every
time you open a new terminal**. Avoid:

- Network calls (DNS lookups, version checks, `curl`).
- Long subshells (`$(...)` doing heavy work).
- Large file scans (`find ~ ...`).

Prefer lazy loading. Example: NVM is sourced (it defines the `nvm`
function), but Node is not auto-loaded — Node only loads when you `nvm
use` or run `node`. Deliberate trade-off.

### Symlinks use `force: true`

[`install.conf.yaml`](./install.conf.yaml) sets dotbot's `force: true`
default, which means existing files at the target paths get
**overwritten** by the symlinks. If you have a precious untracked
`~/.zshrc` from before, back it up before your first `./install`:

```bash
cp ~/.zshrc ~/.zshrc.preinstall
```

## Repository layout

```
.dotfiles/
├── README.md              ← you are here
├── Makefile               ← convenience targets (install, update, ...)
├── install                ← thin wrapper that calls dotbot
├── install.conf.yaml      ← what gets symlinked where
├── setup.sh               ← full system bootstrap (apt + conda + clone)
├── .gitmodules            ← submodule declarations
├── .gitignore             ← repo hygiene
├── dotbot/                ← (submodule) the symlink manager
└── shell/
    ├── .bashrc            ← bash interactive rc
    ├── .zshrc             ← zsh interactive rc (orchestrator)
    ├── .inputrc           ← readline keybindings (used by bash)
    ├── .vimrc             ← vim config
    ├── .tmux.conf         ← tmux config
    ├── .wezterm.lua       ← WezTerm terminal-emulator config
    ├── .p10k.zsh          ← Powerlevel10k prompt config
    ├── env.sh             ← shared bash+zsh env (sourced by both rcs)
    ├── zsh/               ← zsh modules (sourced by .zshrc)
    │   ├── options.zsh
    │   ├── aliases.zsh
    │   └── functions.zsh
    ├── .vim/              ← vim plugin pack (most subdirs are submodules)
    ├── .oh-my-zsh/        ← vendored oh-my-zsh + (submodule) customs
    └── .config/
        └── nvim/          ← neovim (lazy.nvim) config
```

## Troubleshooting

**`./install` fails on a fresh clone with "submodule … not initialized".**
You skipped `git submodule update --init --recursive` (or
`make submodules-init`). Run it.

**Zsh starts but my prompt is the default, not Powerlevel10k.**
Either p10k didn't install (check that
`shell/.oh-my-zsh/custom/themes/powerlevel10k/` is non-empty) — fix by
running `make submodules-init` — or `~/.p10k.zsh` is missing — run
`p10k configure`.

**Conda is on `PATH` twice / `conda init` warnings on shell start.**
You ran `conda init` manually, which appended a duplicate block to
`~/.bashrc` or `~/.zshrc`. See
[Conda init caveat](#conda-init-caveat).

**`./install` says "removed link" or refuses to overwrite.**
There is a real file (not a symlink) at the target path. Move it aside
(e.g. `mv ~/.zshrc ~/.zshrc.preinstall`) and re-run `./install`.

**`make update` fails with "non-fast-forward".**
You have local commits on `master` that diverge from `origin/master`.
Resolve manually (`git pull --rebase` or `git merge`). `make update`
deliberately uses `--ff-only` to refuse surprise merges.

## Glossary

- **Dotfile**: A configuration file in your home directory whose name
  starts with `.` (and is therefore hidden by default).
- **Dotbot**: A small Python tool that creates and maintains symlinks
  based on a YAML config. The mechanism behind `./install`.
- **Symbolic link / symlink**: A filesystem entry that "points to"
  another file. Reading or editing the symlink reads/edits the target.
  Created with `ln -s`.
- **Submodule (git)**: A git repository pinned at a specific commit
  inside another git repository. Useful for vendoring third-party code
  while keeping it auditable and upgradeable.
- **Oh-my-zsh**: A community framework on top of Zsh that bundles
  plugins, themes, and a plugin loader. We use it primarily for
  `plugins=(...)` and theme support.
- **Powerlevel10k (p10k)**: A fast, configurable Zsh prompt theme.
- **lazy.nvim**: A modern Neovim plugin manager. Loads plugins on demand
  based on filetype, command, etc.
- **NVM** (Node Version Manager): Lets you install and switch between
  Node.js versions per shell.
- **bun**: A fast JavaScript runtime / package manager / bundler.
- **Conda / Miniconda**: Python (and more) environment & package
  manager. Miniconda is the small variant.
- **POSIX shell**: The lowest-common-denominator shell language (no
  bash-isms or zsh-isms). `env.sh` is written in it so both bash and
  zsh can source it.
- **Login shell vs interactive shell**: A *login* shell is what you get
  on `ssh user@host` or at a TTY login. An *interactive* shell is
  anything you type into. They read different rc files. This repo
  manages interactive rc files (`.bashrc`, `.zshrc`).

## Credits

This repo stands on the shoulders of:

- [dotbot] — symlink management
- [oh-my-zsh] — Zsh framework
- [Powerlevel10k] — Zsh prompt
- [lazy.nvim] — Neovim plugin manager
- [Catppuccin] — Neovim colorscheme
- [tpope/vim-surround], [preservim/nerdtree], [ctrlpvim/ctrlp.vim],
  [easymotion/vim-easymotion], [mileszs/ack.vim] — vim plugins
- [zsh-users/zsh-syntax-highlighting], [zsh-users/zsh-autosuggestions]
  — zsh plugins

Conceptually inspired by Anish Athalye's
[*"Managing your dotfiles"*](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/),
which is the original case for the dotbot model.

[dotbot]: https://github.com/anishathalye/dotbot
[Catppuccin]: https://github.com/catppuccin/nvim
[tpope/vim-surround]: https://github.com/tpope/vim-surround
[preservim/nerdtree]: https://github.com/preservim/nerdtree
[ctrlpvim/ctrlp.vim]: https://github.com/ctrlpvim/ctrlp.vim
[easymotion/vim-easymotion]: https://github.com/easymotion/vim-easymotion
[mileszs/ack.vim]: https://github.com/mileszs/ack.vim
[zsh-users/zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
[zsh-users/zsh-autosuggestions]: https://github.com/zsh-users/zsh-autosuggestions

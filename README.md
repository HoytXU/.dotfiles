# Dotfiles

Personal configuration files for development environment. Uses [dotbot](https://github.com/anishathalye/dotbot) for symlink management.

## Contents

**Shell & Terminal:**
- `bash` (`.bashrc`, `.inputrc`)
- `zsh` (`.zshrc`, `.p10k.zsh`, oh-my-zsh with powerlevel10k theme)
- `shared` (`env.sh` — sourced by both `.bashrc` and `.zshrc`: secrets, conda init, PATH, NVM, bun)
- `tmux` (`.tmux.conf`)
- `wezterm` (`.wezterm.lua`, background image)

**Editors:**
- `vim` (`.vimrc`, `.vim/` with plugins: ctrlp, nerdtree, easymotion, surround, fugitive, ack, colorschemes)
- `neovim` (`.config/nvim/`)

**Dependencies:**
- Git submodules: dotbot, vim plugins, oh-my-zsh plugins/themes, tldr pages

## Quick Setup

### Automated (Full System Setup)
```bash
bash <(curl -sSL https://raw.githubusercontent.com/HoytXU/.dotfile/master/setup.sh)
```
Installs: zsh, neovim (unstable), tmux, npm, tldr, conda, and configures dotfiles.

### Manual (Dotfiles Only)
```bash
git clone https://github.com/HoytXU/.dotfile.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
./install
```

## Requirements

- **OS:** Linux (Ubuntu 20.04+ preferred)
- **Dependencies:** `npm` (for pyright, markdown-preview), `python3.12-venv` (for pylsp)
- **Packages:** zsh, neovim, tmux, git, curl, wget

## Usage

### Apply Changes
```bash
cd ~/.dotfiles && ./install
```

### Add New Configuration
1. Place config file in `shell/` directory
2. Add symlink entry to `install.conf.yaml`:
   ```yaml
   - link:
       ~/.newconfig: shell/.newconfig
   ```
3. Run `./install`
4. Commit: `git add . && git commit -m "feat(config): Add .newconfig"`

### Remove Configuration
1. Remove entry from `install.conf.yaml`
2. Remove file: `git rm shell/.oldconfig`
3. Run `./install` (removes symlink)
4. Commit changes

### Update Submodules
```bash
git submodule update --init --recursive
git submodule update --remote  # Update to latest commits
```

## Structure

```
.dotfiles/
├── install                 # Dotbot wrapper script
├── install.conf.yaml       # Symlink configuration
├── setup.sh               # Full system setup script
├── shell/                 # All config files
│   ├── .bashrc
│   ├── .zshrc
│   ├── env.sh             # Shared env sourced by .bashrc and .zshrc
│   ├── .vimrc
│   ├── .tmux.conf
│   ├── .vim/              # Vim plugins (submodules)
│   ├── .oh-my-zsh/        # Oh-my-zsh (submodules)
│   ├── .config/nvim/      # Neovim config
│   └── ...
└── dotbot/                # Dotbot submodule
```

## Git Submodules

**Vim Plugins:**
- ctrlp.vim, nerdtree, vim-easymotion, vim-surround, fugitive.vim, ack.vim, vim-colorschemes

**Zsh:**
- oh-my-zsh, powerlevel10k theme, zsh-syntax-highlighting, zsh-autosuggestions

**Tools:**
- tldr-pages, dotbot

## Notes

- Symlinks are created with `force: true` (overwrites existing files)
- Setup script auto-detects network issues and switches to TUNA mirror (China)
- Conda is installed to `~/miniconda3` if not present
- After setup, restart terminal or run `zsh` to activate new shell
- `shell/env.sh` holds shared shell env (secrets source, conda init, PATH, NVM, bun) and is sourced by both `.bashrc` and `.zshrc`. It is **not** symlinked — both rc files reference it directly via `$HOME/.dotfiles/shell/env.sh`, so the repo must live at `~/.dotfiles`.
- **Conda init caveat:** running `conda init` manually (or after a conda upgrade prompts you to re-run it) writes a managed `>>> conda initialize >>>` block back into `~/.bashrc` and `~/.zshrc`. If that happens, fold any new content into `shell/env.sh` and remove the duplicate block from the rc file to avoid double-initializing conda. `setup.sh` itself no longer calls `conda init`.
- **Oh-my-zsh vendoring (intentional):** `shell/.oh-my-zsh/` is a vendored snapshot of [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (~18 MB, taken 2024-09, no local modifications), not a submodule. Plugins and themes under `custom/` ARE submodules. Converting the OMZ core to a submodule or runtime-install would require relocating those customs first, because nested submodules don't compose cleanly. Kept as-is for now; revisit when the snapshot becomes too stale to support a needed plugin, or when repo size matters. To refresh manually without changing the model: `rm -rf shell/.oh-my-zsh/{lib,plugins,themes,tools,templates,oh-my-zsh.sh,*.md,LICENSE.txt}` then re-copy from a fresh upstream clone (preserve `custom/` and `cache/.gitkeep`).

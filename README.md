# Dotfiles

Personal configuration files for development environment. Uses [dotbot](https://github.com/anishathalye/dotbot) for symlink management.

## Contents

**Shell & Terminal:**
- `bash` (`.bashrc`, `.inputrc`)
- `zsh` (`.zshrc`, `.p10k.zsh`, oh-my-zsh with powerlevel10k theme)
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
bash <(curl -sSL https://raw.githubusercontent.com/HoytXU/.dotfile/main/setup.sh)
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

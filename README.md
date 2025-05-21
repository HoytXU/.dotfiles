# This dotfile includes my personal settings of:
- vim
- neovim
- bash
- zsh
- tmux

## Environment
- OS: Ubuntu 20.04 as default
npm is needed for pyright, markdown-preview
python3.12-venv is needed for pylsp

## Set up
1. Go to your root directory
cd ~

2. Clone this dotfile git
git clone https://github.com/HoytXU/.dotfile.git
cd .dotfile

# When you clone a repository with modules, you have to do this 
git submodule update --init --recursive

3. Install
Just run ./install inside the .dotfile directory.

## Adding New Configurations
To add a new configuration file (e.g., `.tmux.conf`):
1. Place your configuration file in the appropriate directory within the dotfile repository.
2. Update the `install.conf.yaml` file to include the new symlink configuration. For example:
   ```yaml
   - link:
       ~/.tmux.conf: shell/.tmux.conf
   ```
3. Run the installer to apply the changes:
   ```bash
   ./install
   ```
4. Commit the changes to the repository:
   ```bash
   git add . 
   git commit -m "feat(tmux): Add config for tmux." # suppose we are using Conventional Commmits
   git push
   ```

## Removing Old Configurations
To remove an old configuration:
1. Remove the corresponding entry from the `install.conf.yaml` file.
2. Remove the configuration file from the dotfile repository:
   ```bash
   git rm path/to/old/config
   ```
3. Run the installer to remove the symlink:
   ```bash
   ./install
   ```
4. Commit the changes to the repository:
   ```bash
   git commit -m "chore(something old): Deleted something old."
   git push
   ```



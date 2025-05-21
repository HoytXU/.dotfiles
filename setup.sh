#!/usr/bin/env bash
set -euo pipefail
trap 'echo ❌ Error on line $LINENO. Exiting.' ERR

REPO_URL="https://github.com/HoytXU/.dotfile.git"
DOTFILE_DIR="$HOME/.dotfiles"

echo "🚀 Starting dotfile setup..."

# 🚫 Prevent running as root
if [[ "$EUID" -eq 0 ]]; then
  echo "❌ This script should NOT be run as root."
  echo "👉 Please run as a regular user (sudo will be used where needed)."
  exit 1
fi

# Detect OS
OS="$(uname -s)"
if [[ "$OS" != "Linux" ]]; then
    echo "❌ Only Linux is supported. Exiting."
    exit 1
fi

# 🌐 Check Ubuntu source
echo "🌍 Checking Ubuntu archive reachability..."
if ! curl -s --head http://archive.ubuntu.com | grep "200 OK" > /dev/null; then
    echo "⚠️  Default Ubuntu source unreachable. Switching to TUNA mirror..."
    sudo sed -i 's|http://.*.ubuntu.com|http://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list
fi

# 📦 Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# 🧪 Add Neovim unstable PPA
echo "🛠️ Adding Neovim unstable PPA..."
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

# 🧱 Install essentials
echo "📦 Installing zsh, tldr, npm, etc..."
sudo apt install -y zsh tldr npm curl git wget python3.12-venv tmux htop nvitop

# ⚙️ Setup dotfiles
if [[ -d "$DOTFILE_DIR" ]]; then
    echo "📦 Dotfile directory already exists. Skipping clone."
else
    echo "📥 Cloning dotfile repo..."
    git clone "$REPO_URL" "$DOTFILE_DIR"
fi

cd "$DOTFILE_DIR"
echo "🔁 Initializing git submodules..."
git submodule update --init --recursive || echo "⚠️ Submodules not fully pulled. Continuing anyway."

echo "🔧 Running dotfile installer..."
if [[ -x "./install" ]]; then
    ./install
else
    echo "❌ Missing or non-executable install script."
    exit 1
fi

# 🐍 Install Miniconda
if command -v conda &>/dev/null; then
    echo "✅ Miniconda already installed. Skipping."
else
    echo "📦 Installing Miniconda to ~/miniconda3..."
    mkdir -p ~/miniconda3
    INSTALLER=~/miniconda3/miniconda.sh

    if ! curl --head --silent --fail https://repo.anaconda.com > /dev/null; then
        echo "⚠️  Using TUNA mirror for Miniconda..."
        wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$INSTALLER"
    else
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$INSTALLER"
    fi

    bash "$INSTALLER" -b -u -p "$HOME/miniconda3"
    rm "$INSTALLER"
fi

# 🧬 Initialize conda
echo "🔁 Activating and initializing conda..."
source ~/miniconda3/bin/activate
conda init --all

echo -e "\n✅ Setup complete! Restart your terminal or run 'zsh' to dive in 🧃"

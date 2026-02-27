#!/bin/bash
NODE_VERSION="v21.5.0"

# very basic packages
sudo apt install -y \
    build-essential \
    git \
    vim \
    openssh \
    zsh

# programming languages
sudo apt install -y \
    clang \
    cmake \
    llvm

# pyenv
# poetry
# rust-analyzer
# rustup

cargo install fnm
fnm install ${NODE_VERSION}
fnm use ${NODE_VERSION}
fnm default ${NODE_VERSION}

# GUI essentials
sudo apt install -y \
    i3-wm \
    xdg-utils \
    x11-apps \
    xorg \
    xinit

# sound and bluetooth
sudo apt install -y \
    bluez \
    pipewire-pulse

sudo systemctl bluetooth

# hangul
sudo apt install -y \
    fcitx5-hangul \
    fcitx5-config-qt \
    fcitx5-frontend-qt5 \
    fonts-noto-cjk

# applications
sudo apt install -y \
    htop \
    curl \
    eza \
    ffmpeg \
    firefox \
    graphviz \
    httpie \
    imagemagick \
    jq \
    less \
    lsb-release \
    neovim \
    newsboat \
    ripgrep \
    rq \
    tmux \
    unzip \
    wget

# obsidian
# dropbox

# language servers, formatters
sudo apt install -y \
    shellharden \
    shfmt

cargo install taplo-cli
npm install -g prettier
npm install -g typescript-language-server
npm install -g vscode-langservers-extracted
npm install -g @fsouza/prettierd
npm install -g @tailwindcss/language-server

# theming & looks
sudo apt install -y \
    feh \
    i3status \
    picom

# ttf-nerd-fonts-symbols

bash "$HOME/dotfiles/scripts/setup-gnome.sh"

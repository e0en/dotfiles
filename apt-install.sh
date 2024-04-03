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
    xorg-apps \
    xorg-server \
    xorg-xinit

# sound and bluetooth
sudo apt install -y \
    bluez \
    bluez-utils \
    pipewire-pulse

sudo systemctl bluetooth

# hangul
sudo apt install -y \
    fcitx5-hangul \
    fctix5-config-qt \
    fctix5-frontend-qt5 \
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
    rxvt-unicode-256color \
    tmux \
    unzip \
    wget

# obsidian
# dropbox

# language servers, formatters
sudo pacman -Syu --needed \
    lua-language-server \
    prettier \
    shellharden \
    shfmt \
    stylua \
    taplo-cli \
    typescript-language-server \
    vscode-json-languageserver \
    yamlfmt

npm install -g @fsouza/prettierd
npm install -g @tailwindcss/language-server

# theming & looks
sudo apt install -y \
    feh \
    i3status \
    picom

# ttf-nerd-fonts-symbols

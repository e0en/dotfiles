#!/bin/bash
NODE_VERSION="v21.5.0"

# very basic packages
sudo pacman -Syu --needed \
    base-devel \
    git \
    vim \
    openssh \
    zsh

# paru to use AUR packages
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# programming languages
sudo pacman -Syu --needed \
    clang \
    cmake \
    llvm \
    pyenv \
    python-poetry \
    rust-analyzer \
    rustup

cargo install fnm
fnm install ${NODE_VERSION}
fnm use ${NODE_VERSION}
fnm default ${NODE_VERSION}

# GUI essentials
sudo pacman -Syu --needed \
    i3-wm \
    ly \
    xdg-utils \
    xorg-apps \
    xorg-server \
    xorg-xinit

# sound and bluetooth
sudo pacman -Syu --needed \
    bluez \
    bluez-utils \
    pipewire-pulse

sudo systemctl bluetooth

# nvidia!
sudo pacman -Syu --needed \
    libva-nvidia-driver \
    nvidia \
    nvidia-prime \
    nvtop

# hangul
sudo pacman -Syu --needed \
    fcitx5-hangul \
    fcitx5-im \
    noto-fonts-cjk

# applications
sudo pacman -Syu --needed \
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
    nnn \
    newsboat \
    obsidian \
    ripgrep \
    rq \
    rxvt-unicode \
    tmux \
    unzip \
    urxvt-perls \
    wget
paru 1password
paru dropbox
paru rustdesk
sudo systemctl enable rustdesk

# make
sudo pacman -Syu --needed \
    blender \
    freecad \
    platformio-core \
    platformio-core-udev \
    prusa-slicer

# machine learning
sudo pacman -Syu --needed \
    cuda \
    opencv-cuda
paru python-jax

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
pacman -Syu --needed \
    feh \
    i3-status \
    picom \
    rofi \
    ttf-nerd-fonts-symbols

paru openrgb
sudo cp $HOME/dotfiles/systemd/openrgb.conf
sudo systemctl enable openrgb
sudo systemctl start openrgb

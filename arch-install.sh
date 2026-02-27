#!/bin/bash
NODE_VERSION="v24"

# very basic packages
sudo pacman -Syu --needed \
    base-devel \
    git \
    vim \
    openssh \
    zsh

# yay to use AUR packages
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# programming languages
yay -Syu --needed \
    clang \
    cmake \
    llvm \
    rust-analyzer \
    rustup
yay -Syu esp-idf
/opt/esp-idf/install.sh

cargo install fnm
fnm install ${NODE_VERSION}
fnm use ${NODE_VERSION}
fnm default ${NODE_VERSION}

# GUI essentials
sudo pacman -Syu --needed \
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

sudo systemctl enable --now bluetooth

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
    obsidian \
    ripgrep \
    rq \
    tmux \
    unzip \
    wget
yay -S --needed 1password

# make
yay -Syu --needed \
    blender \
    freecad \
    prusa-slicer

# machine learning
yay -Syu --needed \
    cuda \
    opencv-cuda \
    python-jax

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
yay -Syu --needed \
    ttf-nerd-fonts-symbols

yay -S --needed openrgb
sudo mkdir -p /etc/systemd/system/openrgb.service.d
sudo cp "$HOME/dotfiles/systemd/openrgb.conf" /etc/systemd/system/openrgb.service.d/override.conf
sudo systemctl daemon-reload
sudo systemctl enable --now openrgb

bash "$HOME/dotfiles/scripts/setup-gnome.sh"

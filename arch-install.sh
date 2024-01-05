#!/bin/bash
NODE_VERSION="v21.5.0"

# system utilities
sudo pacman -Syu --needed \
  git \
  vim \
  openssh \
  zsh

# GUI
sudo pacman -Syu --needed \
  i3-wm \
  i3lock \
  ly \
  polybar \
  rofi \
  xdg-utils \
  xorg-apps \
  xorg-server \
  xorg-xinit

# hangul
sudo pacman -Syu --needed \
  fcitx5-hangul \
  noto-fonts-cjk

# applications
sudo pacman -Syu --needed \
  blender \
  btop \
  clang \
  cmake \
  cuda \
  curl \
  eza \
  ffmpeg \
  firefox \
  freecad \
  go \
  graphviz \
  httpie \
  imagemagick \
  jq \
  less \
  llvm \
  lua-language-server \
  neovim \
  nnn \
  poetry \
  prettier \
  prusa-slicer \
  pyenv \
  ripgrep \
  rq \
  shellharden \
  shfmt \
  stylua \
  taplo \
  tmux \
  typescript-language-server \
  unzip \
  wezterm \
  wget \
  yamlfmt

paru 1password
paru dropbox

cargo install fnm
fnm install ${NODE_VERSION}
fnm use ${NODE_VERSION}
fnm default ${NODE_VERSION}

npm install -g @fsouza/prettierd
npm install -g @tailwindcss/language-server

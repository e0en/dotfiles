#!/bin/zsh
platform='unknown'

unamestr=$(uname)

if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" == "Darwin" ]]; then
    platform='macos'
else
    >&2 echo "$unamestr is not supported."
    exit 1
fi

if [ -e "$HOME/.config" ] && [ ! -L "$HOME/.config" ]; then
    backup_path="$HOME/.config.old.$(date +%Y%m%d%H%M%S)"
    mv "$HOME/.config" "$backup_path"
fi
ln -sfn "$HOME/dotfiles/.config" "$HOME/.config"


if [[ $platform == 'macos' ]]; then
    if ! xcode-select -p &> /dev/null; then
        xcode-select --install
    fi

    if [ ! -d "/opt/homebrew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew bundle
fi

# cargo
if [ ! -d "$HOME/.cargo" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    export PATH="$HOME/.cargo/bin:$PATH"
fi
cargo install difftastic
cargo install eza
cargo install fnm


# zsh
if [ ! -d "$HOME/.zim" ]; then
    cp $HOME/.zshrc $HOME/.zshrc.before-zim
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    mv $HOME/.zshrc.before-zim $HOME/.zshrc
fi

if [ ! -d ~/.zsh-async ]; then
    git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi

# nvim
if [ ! -f $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
   $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

npm i -g vscode-langservers-extracted

# wgpu
cargo install --git https://github.com/wgsl-analyzer/wgsl-analyzer wgsl_analyzer

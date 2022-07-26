#!/bin/zsh
platform='unknown'

if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" == "Darwin" ]]; then
    platform='macos'
else
    >&2 echo "$unamestr is not supported."
    exit 1
fi

if [ -d "$HOME/.config" ]; then
    mv $HOME/.config $HOME/.config.old
fi
ln -s $HOME/dotfiles/.config $HOME/.config


if [[ $platform == 'macos' ]]; then
    xcode-select &> /dev/null
    if [ ! $? ]; then
        xcode-select --install
    fi

    if [ ! -d "/opt/homebrew" ]; then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
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
cargo install exa
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
if [ ! -f "$HOME/dotfiles/.config/nvim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

nvim -c ':PlugUpgrade | :PlugUpdate | qa!'

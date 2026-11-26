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
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"

    "${0:A:h}/scripts/update-zerobrew.sh" || exit 1
    "${ZEROBREW_BIN:-$HOME/.local/bin}/zb" bundle install --file "${0:A:h}/Brewfile" || exit 1
    brew bundle --file "${0:A:h}/Brewfile.casks" || exit 1
    export PATH="${ZEROBREW_PREFIX:-${ZEROBREW_ROOT:-/opt/zerobrew}}/bin:${ZEROBREW_PREFIX:-${ZEROBREW_ROOT:-/opt/zerobrew}}/sbin:$PATH"
    UV_PYTHON_BIN_DIR="$HOME/.local/bin" uv python install 3.15 --default || exit 1
    "$HOME/.local/bin/python" --version || exit 1
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
ZIM_HOME="${ZDOTDIR:-$HOME}/.zim"
if [[ ! -f "$ZIM_HOME/zimfw.zsh" ]]; then
    curl -fsSL --create-dirs -o "$ZIM_HOME/zimfw.zsh" \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh || exit 1
fi
if [[ ! -e "${ZDOTDIR:-$HOME}/.zimrc" ]]; then
    cp "${0:A:h}/.zimrc" "${ZDOTDIR:-$HOME}/.zimrc" || exit 1
fi
(source "$ZIM_HOME/zimfw.zsh" install) || exit 1

if [ ! -d ~/.zsh-async ]; then
    git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi

npm i -g vscode-langservers-extracted

# wgpu
cargo install --git https://github.com/wgsl-analyzer/wgsl-analyzer wgsl_analyzer

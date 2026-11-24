# detect OS to have platform-specific settings
platform='unknown'
os_name=$(uname -s | tr '[:upper:]' '[:lower:]')

case "${os_name}" in
    linux*)
        platform='linux'
        ;;
    darwin*)
        platform='macos'
        ;;
    *)
        >&2 echo "Operating system ${os_name} is not supported."
        exit 1
        ;;
esac

if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

if [ ! -d "$HOME/.zim" ]; then
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    source $HOME/dotfiles/.zim-zshrc
fi

# basic path settings
typeset -U path
path=("$HOME/.local/bin" $path)

if [[ $platform == 'linux' ]]; then
    export PATH=/usr/local/bin:$PATH
    dist=`lsb_release -si`

    if [[ $dist == "Arch" ]]; then
      function update_pkg () {
        MAKEFLAGS="-j$(nproc)" yay -Syu
      }
    else
      function update_pkg () {
          sudo apt -yy update
          sudo apt -yy upgrade
          sudo apt -yy autoremove
      }
    fi
elif [[ $platform == "macos" ]]; then
    function update_pkg () {
        # Homebrew still owns zerobrew itself, casks, and pre-existing packages.
        brew update || return
        brew upgrade || return
        brew cleanup -s || return
        if command -v zb >/dev/null 2>&1; then
            zb update || return
            zb upgrade || return
            zb gc || return
        fi
        softwareupdate --all --install --force
    }
fi


function pip-install-basics () {
    uv tool install --managed-python --python 3.15 ruff || return
    uv tool install --managed-python --python 3.15 ty
}

function update-all () {
    pushd $HOME/dotfiles
    git pull --rebase --autostash
    popd

    rustup update || return
    update_pkg || return
    uv python upgrade || return
    uv tool upgrade --all || return
    local node_major=$(fnm exec --using=default node -p 'process.versions.node.split(".")[0]')
    local -a node_tools
    node_tools=("${(@f)$(fnm exec --using=default npm list --global --depth=0 --json | python -c 'import json,sys; print("\n".join(json.load(sys.stdin).get("dependencies", {})))')}")
    fnm install "$node_major" --use || return
    if (( ${#node_tools} )); then
        SHARP_IGNORE_GLOBAL_LIBVIPS=1 npm install --global "${node_tools[@]}" || return
    fi
    fnm default "$(node --version)" || return
    if command -v flatpak >/dev/null; then
        flatpak update || return
    fi
    cargo install $(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
}

function install-esp-idf () {
    readonly port=${1:?"The version must be specified. https://github.com/espressif/esp-idf/tags"}
    rm -rf $HOME/esp
    mkdir -p $HOME/esp
    cd $HOME/esp
    git clone -b $1 --recursive https://github.com/espressif/esp-idf.git
    cd $HOME/esp/esp-idf
    ./install.sh all
}

function cleanup_git {
    git remote prune origin
    git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
    git branch -vv | grep -v "\]" | awk '{print $1}' | xargs git branch -D
}


function kitty-theme {
  THEME_FILE="$HOME/.kitty-themes/themes/$1"

  # Check if the theme file exists
  if [ ! -f "$THEME_FILE" ]; then
      echo "Theme file does not exist: $THEME_FILE"
      return 1
  fi
  ln -s -f "$THEME_FILE" "$HOME/.config/kitty/theme.conf"
  kitty @ set-colors -a -c "$THEME_FILE"
}

# Load compinit if not already loaded
if (( ! ${+functions[compdef]} && ! ${+functions[compadd]} )); then
  autoload -Uz compinit
  compinit
fi

function _complete_kitty_theme {
  local -a theme_files
  theme_files=(${(f)"$(find $HOME/.kitty-themes/themes/*.conf -exec basename {} \;)"})
  _describe 'theme file' theme_files
}
compdef _complete_kitty_theme kitty-theme

zmodload zsh/zprof

if [[ $platform == "macos" ]]; then
    if [ ! -d "/opt/homebrew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source $HOME/dotfiles/homebrew-github-token.sh
    # Prefer zerobrew packages while retaining the real brew for casks/services.
    typeset -U path
    path=("${ZEROBREW_PREFIX:-${ZEROBREW_ROOT:-/opt/zerobrew}}/bin"
          "${ZEROBREW_PREFIX:-${ZEROBREW_ROOT:-/opt/zerobrew}}/sbin" $path)
fi

# locale!
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# fix text rendering
# https://unix.stackexchange.com/questions/598440/zsh-indic-fonts-support-rendering-issue-which-is-working-fine-on-bash
setopt COMBINING_CHARS


# python
export PYTHON_CONFIGURE_OPTS="--enable-shared"
export KICAD_PARTS="$HOME/Developer/kicad-parts"

# golang
export PATH="$HOME/go/bin:$PATH"

# rust
if [ -d "$HOME/.cargo" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# javascript
export PATH="./node_modules/.bin:$PATH"
eval "$(fnm env)"

export EDITOR="nvim"

# thefuck
if whence -cp thefuck &> /dev/null; then
    eval $(thefuck --alias)
fi

alias mux="tmuxinator"

# Install zsh-async if it’s not present
if [ ! -d ~/.zsh-async ]; then
    git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi
source ~/.zsh-async/async.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# nnn preview
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='1:ipinfo;p:preview-tui;o:fzz;b:nbak'

# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias ls='eza -gls type --color=always'
alias vim='nvim'
alias ssh='TERM=xterm-256color ssh'
alias nnn='nnn -a -H -Pp'

alias pbcopy="xsel --clipboard --input"
alias pbpbaste="xsel --clipboard --output"
alias espenv="source /opt/esp-idf/export.sh"

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

if [ ! -f $HOME/.profile ]; then
    source $HOME/.profie
fi

if [ ! -d "$HOME/.zim" ]; then
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    source $HOME/dotfiles/.zim-zshrc
fi

# basic path settings
if [[ $platform == 'linux' ]]; then
    export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
    dist=`lsb_release -si`

    if [[ $dist == "Arch" ]]; then
      function update_pkg () {
        paru -Syu
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
        brew update
        brew upgrade
        brew cleanup -s
        softwareupdate --all --install --force
    }
fi


function pip-install-basics () {
    pip install -U wheel pip setuptools
    pip install python-language-server flake8
}

function update-all () {
    pushd $HOME/dotfiles
    git reset --hard
    git pull --rebase
    popd

    rustup update
    update_pkg
    cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
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
fi

# locale!
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# fix text rendering
# https://unix.stackexchange.com/questions/598440/zsh-indic-fonts-support-rendering-issue-which-is-working-fine-on-bash
setopt COMBINING_CHARS


# python
export PYTHON_CONFIGURE_OPTS="--enable-shared"

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

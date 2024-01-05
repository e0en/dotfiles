# detect OS to have platform-specific settings
unamestr=`uname`
platform='unknown'

if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" == "Darwin" ]]; then
    platform='macos'
else
    >&2 echo "$unamestr is not supported."
    exit 1
fi

# basic path settings
if [[ $platform == 'linux' ]]; then
    export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

    function update_pkg () {
        sudo apt -yy update
        sudo apt -yy upgrade
        sudo apt -yy autoremove
    }
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

function cleanup_git {
    git remote prune origin
    git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
    git branch -vv | grep -v "\]" | awk '{print $1}' | xargs git branch -D
}

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

if [ ! -d "$HOME/.zim" ]; then
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    source $HOME/dotfiles/.zim-zshrc
fi

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
alias ls='eza -Fgls type --color=always'
alias vim='nvim'
alias ssh='TERM=xterm-256color ssh'
alias nnn='nnn -a -H -Pp'

alias pbcopy="xsel --clipboard --input"
alias pbpbaste="xsel --clipboard --output"

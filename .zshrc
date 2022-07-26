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

is_ec2=false
LOCAL_HOSTNAME=$(hostname -f)
if [[ ${LOCAL_HOSTNAME} =~ .*\.compute\.internal ]]; then
    is_ec2=true
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


function upgrade-pyenv () {
    pyenv shell $1
    pip install -U pip wheel
    pip install poetry
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  > /tmp/upgrade_pyenv.txt
    pip install -U -r /tmp/upgrade_pyenv.txt
    pyenv shell --unset
}

function migrate-pyenv () {
    pyenv shell $1
    pip freeze | grep -v '^\-e' | cut -d = -f 1 > /tmp/$1.req.txt
    pyenv shell --unset
    pyenv uninstall $1
    pyenv virtualenv $2 $1
    pyenv shell $1
    pip install -U wheel pip setuptools
    pip install -U -r /tmp/$1.req.txt
    pip install -U pip
    pyenv shell --unset
}

function pip-install-basics () {
    pip install -U wheel pip setuptools
    pip install python-language-server flake8
}

function update-all () {
    pushd $HOME/dotfiles
    git stash
    git pull --rebase
    git stash pop
    popd

    pyenv update
    rustup update
    update_pkg
    nvim -c ':PlugUpgrade | :PlugUpdate | qa!'
}

function cleanup_git {
    git remote prune origin
    git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
    git branch -vv | grep -v "\]" | awk '{print $1}' | xargs git branch -D
}

zmodload zsh/zprof

# locale!
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


if [ ! -d "$HOME/.zim" ]; then
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    source $HOME/dotfiles/.zim-zshrc
fi

# python
export PYTHON_CONFIGURE_OPTS="--enable-shared"
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init - | sed s/precmd/precwd/g)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

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
export DISPLAY='' # nullify DISPLAY to disable xquartz

# sort unique lines by occurences
sortuniq () {
    sort $1 | uniq -c | sort -bgr
}

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

# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias ls='exa -Fgl --color=always'
alias vim='nvim'

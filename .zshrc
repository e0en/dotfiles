# detect OS to have platform-specific settings
unamestr=`uname`
platform='unknown'

if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" == "Darwin" ]]; then
    platform='osx'
fi

is_ec2=false
LOCAL_HOSTNAME=$(hostname -f)
if [[ ${LOCAL_HOSTNAME} =~ .*\.compute\.internal ]]; then
    is_ec2=true
fi


# basic path settings
if [[ $platform == 'osx' ]]; then
    source $HOME/dotfiles/osx-env.sh
fi

if [[ $platform == 'linux' ]]; then
    export PATH=/usr/local/bin:$PATH

    function update_pkg () {
        sudo apt -yy update
        sudo apt -yy upgrade
        sudo apt -yy autoremove
    }
fi


function upgrade_pyenv () {
    pyenv activate $1
    pip install -U pip
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
    pyenv deactivate
}

function migrate_pyenv () {
    pyenv activate $1
    pip freeze > $1.req.txt
    pyenv deactivate
    pyenv uninstall $1
    pyenv virtualenv $2 $1
    pyenv activate $1
    pip install -r $1.req.txt
    pyenv deactivate
}


function migrate_pyenv () {
    pyenv activate $1
    pip freeze | grep -v '^\-e' | cut -d = -f 1 > /tmp/$1.req.txt
    pyenv deactivate
    pyenv uninstall $1
    pyenv virtualenv $2 $1
    pyenv activate $1
    pip install -U pip
    pip install -r /tmp/$1.req.txt
}


function update_all () {
    pushd $HOME/dotfiles
    git stash
    git pull --rebase
    git stash pop
    popd

    pyenv update
    upgrade_oh_my_zsh
    update_pkg
}


# python
export PYTHON_CONFIGURE_OPTS="--enable-shared"
if [[ -a "$HOME/.pyenv" ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# editor
export EDITOR=vim
export DISPLAY='' # nullify DISPLAY to disable xquartz

# sort unique lines by occurences
sortuniq () {
    sort $1 | uniq -c | sort -bgr
}

# calc base64-encoded sha384 hash of a file
base64sha384 () {
    openssl dgst -sha384 -binary < $1 | openssl enc -base64
}

# thefuck
if whence -cp thefuck &> /dev/null; then
    eval $(thefuck --alias)
fi

alias mux="tmuxinator"

# Install zsh-async if it’s not present
if [[ ! -a ~/.zsh-async ]]; then
    git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi
source ~/.zsh-async/async.zsh

export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Initialize a new worker
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="frisk"

export UPDATE_ZSH_DAYS=13
export DISABLE_UPDATE_PROMPT=true
plugins=(git osx github python pyenv)
source $ZSH/oh-my-zsh.sh

# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias rebase='git fetch origin master && git rebase -i --autosquash origin/master'
alias scrum='gitlog && grep "TODO:" *.py'
alias is="ssh bbsutf8@isb.or.kr"
alias update_pip="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -Fgl --color=always'

# cosmetics
export LS_COLORS="$LS_COLORS:ow=01;36;40"

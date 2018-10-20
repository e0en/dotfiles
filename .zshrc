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

export PATH=/usr/local/bin:$PATH

# python
export PYTHON_CONFIGURE_OPTS="--enable-shared"
if [[ -a "$HOME/.pyenv" ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# ruby
if [[ -a "$HOME/.rbenv" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi

# js
if [[ -a "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi


# jvm
if [[ -a "/usr/libexec/java_home" ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# go
if [[ -a "/usr/local/opt/go" ]]; then
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
fi

# editor
export EDITOR=vim
export DISPLAY='' # nullify DISPLAY to disable xquartz

# sort unique lines by occurences
sortuniq () {
    sort $1 | uniq -c | sort -bgr
}


# ZSH-specific settings
if [[ -a "/usr/local/share/zsh-syntax-highlighting/" ]]; then
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -a "/usr/local/share/zsh-autosuggestions/" ]]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="risto"

export UPDATE_ZSH_DAYS=13
export DISABLE_UPDATE_PROMPT=true
plugins=(git osx github python)
source $ZSH/oh-my-zsh.sh

# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias rebase='git fetch origin master && git rebase -i --autosquash origin/master'
alias scrum='gitlog && grep "TODO:" *.py'
alias is="ssh bbsutf8@isb.or.kr"

alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -Fgl --color=always'

if whence -cp thefuck 2> /dev/null; then
    eval $(thefuck --alias)
fi

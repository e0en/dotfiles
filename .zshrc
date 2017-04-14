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
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1


# haskell
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# ruby
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH=$HOME/.rvm/gems/ruby-2.1.2/bin:$PATH


# js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


# jvm
export JAVA_HOME=$(/usr/libexec/java_home)


# go
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# editor
export EDITOR=vim
export DISPLAY='' # nullify DISPLAY to disable xquartz

# sort unique lines by occurences
sortuniq () {
    sort $1 | uniq -c | sort -bgr
}


# ZSH-specific settings
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# oh-my-zsh
export ZSH=/Users/e0en/.oh-my-zsh
ZSH_THEME="robbyrussell"

export UPDATE_ZSH_DAYS=13
export DISABLE_UPDATE_PROMPT=true
plugins=(git osx github python scala sbt)
source $ZSH/oh-my-zsh.sh

# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias rebase='git fetch origin master && git rebase -i --autosquash origin/master'
alias scrum='gitlog && grep "TODO:" *.py'

# crontab for OSX
alias crontab="env EDITOR=/usr/bin/vim crontab"
eval "$(hub alias -s)"

alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -FGl --color=always'

# dafuq?
eval $(thefuck --alias)

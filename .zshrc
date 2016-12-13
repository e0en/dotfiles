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

export PATH=/usr/local/bin:$PATH # Add RVM to PATH for scripting

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# ruby settings
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH=$HOME/.rvm/gems/ruby-2.1.2/bin:$PATH

# nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias scrum='gitlog && grep "TODO:" *.py'

alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -FGl'
alias is='ssh bbsutf8@isb.or.kr'

# crontab for OSX
alias crontab="env EDITOR=/usr/bin/vim crontab"

eval "$(hub alias -s)"

# ZSH-specific settings
ZSH_THEME="risto"
plugins=(git pep8 pip pylint python scala tmux rvm)
DISABLE_UPDATE_PROMPT=true


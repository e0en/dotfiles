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
export PATH=/usr/local/bin:$PATH # Add RVM to PATH for scripting
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/OpenBLAS/lib

if [[ $platform == 'osx' ]]; then
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
    export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

# python settings
export PYTHONPATH=$PYTHONPATH:$HOME/lib/py

# ruby settings
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH=$HOME/.rvm/gems/ruby-2.1.2/bin:$PATH


# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias scrum='gitlog && grep "TODO:" *.py'

alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -FGl --color=always --hide="*.pyc"'
# alias is='ssh bbsutf8@isb.or.kr'

# crontab for OSX
alias crontab="env EDITOR=/usr/bin/vim crontab"

eval "$(hub alias -s)"

# ZSH-specific settings
ZSH_THEME="ys"
plugins=(git pep8 pip pylint python scala tmux rvm)
DISABLE_UPDATE_PROMPT=true

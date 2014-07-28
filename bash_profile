# basic path settings
export PATH=/usr/local/bin:$PATH # Add RVM to PATH for scripting
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/OpenBLAS/lib


# python settings
export PYTHONPATH=$PYTHONPATH:$HOME/lib/py
source /usr/local/bin/virtualenvwrapper.sh
workon frograms


# ruby settings
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 2.1.2
rvm gemset use guinness


# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias scrum='gitlog && grep "TODO:" *.py'


# detect OS to have platform-specific settings
unamestr=`uname`
platform='unknown'
if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" == "Darwin" ]]; then
    platform='osx'
fi

# autocompletion
if [[ $platform == 'linux' ]]; then
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
elif [[ $platform == 'osx' ]]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

# colors and prompt
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

. ~/dotfiles/bash_prompt

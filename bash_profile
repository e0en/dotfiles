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

if [[ $is_ec2 == true ]]; then
    source /usr/bin/virtualenvwrapper.sh
else
    source /usr/local/bin/virtualenvwrapper.sh
fi
workon frograms


# ruby settings
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 2.1.2
rvm gemset use frograms


# aliases
alias gitlog='git log --oneline --date-order --graph --since="yesterday" --decorate'
alias scrum='gitlog && grep "TODO:" *.py'


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
eval `dircolors -b $HOME/dotfiles/dircolors.256dark`
export LSCOLORS=$LS_COLORS
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -FGl --color=always'
alias python='ipython'

. $HOME/dotfiles/bash_prompt

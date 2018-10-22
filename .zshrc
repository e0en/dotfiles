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

    function update_all () {
        pyenv update
        upgrade_oh_my_zsh
        sudo apt -yy update
        sudo apt -yy upgrade
        sudo apt -yy autoremove
    }
fi

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
    eval "$(rbenv init -)"
fi

# js
if [[ -a "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
	nvm() {
		unset -f nvm
		export NVM_DIR=~/.nvm
		[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
		nvm "$@"
	}

	node() {
		unset -f node
		export NVM_DIR=~/.nvm
		[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
		node "$@"
	}

	npm() {
		unset -f npm
		export NVM_DIR=~/.nvm
		[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
		npm "$@"
	}
fi

# editor
export EDITOR=vim
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

# cosmetics
export LS_COLORS="$LS_COLORS:ow=01;36;40"

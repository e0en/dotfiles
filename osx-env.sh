export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/OpenBLAS/lib
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export ANDROID_HOME=$HOME/Library/Android/sdk

# crontab for OSX
alias crontab="env EDITOR=/usr/bin/mvim -f crontab"

function update_pkg () {
    brew update
    brew upgrade
    brew cleanup -s
}

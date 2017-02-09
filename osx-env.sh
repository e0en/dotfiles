export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/OpenBLAS/lib
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export ANDROID_HOME=$HOME/Library/Android/sdk

test -e "$HOME/.iterm2_shell_integration.zsh" && . "$HOME/.iterm2_shell_integration.zsh"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/OpenBLAS/lib
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export ANDROID_HOME=$HOME/Library/Android/sdk

export HOMEBREW_PREFIX="$(brew --prefix)/opt"
export READLINE_ROOT_DIR="${HOMEBREW_PREFIX}/readline"
export OPENSSL_ROOT_DIR="${HOMEBREW_PREFIX}/openssl@1.1"
export SQLITE_ROOT_DIR="${HOMEBREW_PREFIX}/sqlite"

export CC=gcc
export CXX=g++
export CFLAGS="-I${READLINE_ROOT_DIR}/include $CFLAGS"
export LDFLAGS="-L${READLINE_ROOT_DIR}/lib $LDFLAGS"
export CFLAGS="-I${OPENSSL_ROOT_DIR}/include $CFLAGS"
export LDFLAGS="-L${OPENSSL_ROOT_DIR}/lib $LDFLAGS"
export CFLAGS="-I${SQLITE_ROOT_DIR}/include $CFLAGS"
export LDFLAGS="-L${SQLITE_ROOT_DIR}/lib $LDFLAGS"
export PATH="${OPENSSL_ROOT_DIR}/bin:$PATH:${OPENSSL_ROOT_DIR}/lib"
export PKG_CONFIG_PATH="${OPENSSL_ROOT_DIR}/lib/pkgconfig"

# crontab for OSX
alias crontab="env EDITOR=/usr/bin/mvim -f crontab"

function update_pkg () {
    brew update
    brew upgrade
    brew cleanup -s
    softwareupdate --all --install --force
}

export ANDROID_HOME=$HOME/Library/Android/sdk

export CC=gcc
export CXX=g++

function update_pkg () {
    brew update
    brew upgrade
    brew cleanup -s
    softwareupdate --all --install --force
}

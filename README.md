dotfiles
========

my settings.


## Usage

run the following

```bash
git clone --recursive git@github.com:e0en/dotfiles
echo "source ~/dotfiles/.bash_profile" > ~/.bash_profile
source ~/.bash_profile
echo "source ~/dotfiles/vimrc" > ~/.vimrc
vim +PluginUpdate +qall
```

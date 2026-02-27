dotfiles
========

my settings.


## Usage

run the following:

```bash
cd $HOME
git clone git@github.com:e0en/dotfiles
echo "source ~/dotfiles/.zshrc" > ~/.zshrc
cd $HOME/dotfiles
./install.sh
```

notes:

- `install.sh` links `$HOME/.config` to this repo.
- when a real `$HOME/.config` already exists, it is backed up to `$HOME/.config.old.YYYYMMDDHHMMSS`.
- restart your terminal after installation.

## Linux setup scripts

- Arch Linux: `./arch-install.sh`
- Debian/Ubuntu: `./apt-install.sh`

These scripts install packages and enable services. Review and run only the one for your distro.

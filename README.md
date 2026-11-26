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

## macOS packages

`install.sh` installs [zerobrew](https://github.com/zerobrewhq/zerobrew)
with its standalone installer. Run `scripts/update-zerobrew.sh` to update the
binary independently of Homebrew. The script also runs during `update-all`.
CLI formulae live in `Brewfile`; GUI casks live in `Brewfile.casks`.

```sh
zb bundle install --file ~/dotfiles/Brewfile
brew bundle --file ~/dotfiles/Brewfile.casks
```

Use `zb install <formula>` for CLI packages. Keep using `brew` for casks,
services, and taps.
The macOS shell prefers zerobrew's bin/sbin directories (by default
`/opt/zerobrew`) over Homebrew's. `ZEROBREW_PREFIX` or `ZEROBREW_ROOT` can
override that location.

`update_pkg` updates both managers and clears their unused caches/store entries.
Existing Homebrew packages are retained and still updated by Homebrew; this
setup does not automatically migrate or uninstall them. Run `./install.sh`
to install the declared packages, then open a new terminal.

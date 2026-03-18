# Repository Guidelines

## Project Structure & Module Organization
This repository manages workstation and editor configuration rather than application code. Root dotfiles such as `.zshrc`, `.tmux.conf`, and `.profile` are linked into `$HOME`. App-specific settings live under `.config/` (for example `.config/nvim`, `.config/git`, `.config/helix`). OS setup entrypoints are at the repo root: [`install.sh`](/Users/e0en/dotfiles/install.sh), [`arch-install.sh`](/Users/e0en/dotfiles/arch-install.sh), and [`apt-install.sh`](/Users/e0en/dotfiles/apt-install.sh). Small helper scripts live in [`scripts/`](/Users/e0en/dotfiles/scripts), and systemd overrides live in [`systemd/`](/Users/e0en/dotfiles/systemd).

## Build, Test, and Development Commands
There is no formal build step. Use the existing scripts directly:

- `./install.sh`: symlinks `.config` into `$HOME`, installs macOS dependencies with Homebrew, and bootstraps shell/editor tools.
- `./arch-install.sh`: installs Arch packages, services, and desktop-related tooling.
- `./apt-install.sh`: installs Debian/Ubuntu packages and language-server dependencies.
- `brew bundle`: syncs macOS packages from `Brewfile`.
- `bash scripts/setup-gnome.sh`: applies GNOME/Nautilus preferences only.

Run only the command relevant to your platform, and review package-install scripts before changing them.

## Coding Style & Naming Conventions
Match the existing style in each file. Shell scripts here use simple Bash or Zsh with 4-space indentation for continued argument lists. Keep changes surgical: prefer editing the platform-specific script that owns the behavior instead of adding wrappers. Name new scripts with clear verb-based kebab case, for example `scripts/update-foo.sh`.

## Testing Guidelines
Testing is manual and command-focused. After changes, run the affected script in a safe environment or validate with targeted commands such as `bash -n install.sh`, `bash -n arch-install.sh`, or `zsh -n .zshrc`. For config changes, verify the target tool starts cleanly after symlinking from a test home directory.

## Commit & Pull Request Guidelines
Recent history uses short imperative subjects, often with a scope prefix like `chore(install): ...` or `fix(install): ...`. Follow that pattern and keep each commit focused on one config area or install flow. Pull requests should state the platform affected, list the scripts or config directories changed, and include manual verification steps. Add screenshots only for visible desktop or editor UI changes.

## Safety & Configuration Notes
`install.sh` replaces `$HOME/.config` with a symlink after backing up a real directory, so avoid changes that could surprise existing users. Prefer idempotent script edits and document any new external dependency near the command that requires it.

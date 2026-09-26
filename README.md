# dotfiles

Portable shell, terminal, editor, and development-environment configuration.
Machine- or employer-specific settings are intentionally kept outside this
repository.

## Install

```sh
git clone git@github.com:jeromeserrano/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh
```

Use `./install.sh --no-packages` to update symlinks without running Homebrew or
mise.

The installer:

- installs Prezto and its submodules when needed;
- links the Zsh, Powerlevel10k, Vim, tmux, WezTerm, Herdr, and mise configs;
- installs the packages in `Brewfile` on macOS; and
- preserves existing regular files as timestamped `.bak` files.

## Machine-local configuration

The tracked Zsh files optionally source these untracked files:

- `~/.zshenv.local` for environment variables and PATH entries needed by every
  shell;
- `~/.zshrc.local` for aliases and other interactive-only behavior.

A personal machine needs neither file. A work machine can provide them from a
separate, approved source without changing this repository.

## Herdr

Only `herdr/config.toml` is synchronized. Sessions, pane history, logs, sockets,
and release notes remain local because they contain machine-specific paths and
terminal history.

## Updating

Edit through either the files in `~/dev/dotfiles` or their home-directory symlinks,
then:

```sh
cd ~/dev/dotfiles
git status
git add <files>
git commit
git push
```

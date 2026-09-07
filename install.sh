#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_PACKAGES=1

if [[ "${1:-}" == "--no-packages" ]]; then
  INSTALL_PACKAGES=0
elif [[ $# -gt 0 ]]; then
  echo "Usage: $0 [--no-packages]" >&2
  exit 2
fi

info()    { echo "[dotfiles] $*"; }
success() { echo "[dotfiles] ✓ $*"; }

symlink() {
  local src="$1" dst="$2" backup

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    backup="$dst.bak"
    if [[ -e "$backup" ]]; then
      backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
    fi
    info "Backing up existing $dst → $backup"
    mv "$dst" "$backup"
  fi

  ln -sfn "$src" "$dst"
  success "$dst"
}

install_prezto() {
  if [[ -d "$HOME/.zprezto/.git" ]]; then
    git -C "$HOME/.zprezto" submodule update --init --recursive
    success "Prezto submodules"
  elif [[ -e "$HOME/.zprezto" ]]; then
    info "Existing ~/.zprezto is not a Git checkout; leaving it unchanged"
  else
    info "Installing Prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
    success "Prezto"
  fi
}

install_prezto

# Zsh and prompt.
symlink "$DOTFILES_DIR/zprezto_runcoms/zshrc"     "$HOME/.zshrc"
symlink "$DOTFILES_DIR/zprezto_runcoms/zpreztorc" "$HOME/.zpreztorc"
symlink "$DOTFILES_DIR/zprezto_runcoms/zprofile"  "$HOME/.zprofile"
symlink "$DOTFILES_DIR/zprezto_runcoms/zshenv"    "$HOME/.zshenv"
symlink "$DOTFILES_DIR/zprezto_runcoms/zlogin"    "$HOME/.zlogin"
symlink "$DOTFILES_DIR/zprezto_runcoms/zlogout"   "$HOME/.zlogout"
symlink "$DOTFILES_DIR/p10k.zsh"                   "$HOME/.p10k.zsh"

# Terminal and editor.
symlink "$DOTFILES_DIR/vimrc"       "$HOME/.vimrc"
symlink "$DOTFILES_DIR/tmux.conf"   "$HOME/.tmux.conf"
symlink "$DOTFILES_DIR/wezterm.lua" "$HOME/.wezterm.lua"

mkdir -p "$HOME/.vim/colors" "$HOME/.vim/autoload"
symlink "$DOTFILES_DIR/vim/colors/everforest.vim" \
  "$HOME/.vim/colors/everforest.vim"
symlink "$DOTFILES_DIR/vim/autoload/everforest.vim" \
  "$HOME/.vim/autoload/everforest.vim"

# Application configuration. Herdr sessions, logs, and scrollback stay local.
mkdir -p "$HOME/.config/herdr"
symlink "$DOTFILES_DIR/herdr/config.toml" "$HOME/.config/herdr/config.toml"

# Runtime versions.
mkdir -p "$HOME/.config/mise"
symlink "$DOTFILES_DIR/mise.toml" "$HOME/.config/mise/config.toml"

if [[ "$INSTALL_PACKAGES" -eq 1 && "$OSTYPE" == darwin* ]]; then
  if command -v brew >/dev/null 2>&1; then
    info "Installing Homebrew bundle..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
    success "Homebrew bundle"
  else
    info "Homebrew is not installed; packages were skipped"
  fi
fi

if [[ "$INSTALL_PACKAGES" -eq 1 ]] && command -v mise >/dev/null 2>&1; then
  info "Installing mise runtimes..."
  mise install
  success "mise runtimes"
fi

success "Done. Restart the shell or run: exec zsh"

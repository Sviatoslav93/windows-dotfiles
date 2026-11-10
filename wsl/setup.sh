#!/usr/bin/env bash
# Set up WSL Ubuntu with the configs in wsl/home. Safe to re-run.
# From Windows:  wsl -d Ubuntu -- bash /mnt/d/windows-dotfiles/wsl/setup.sh
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
arch="$(uname -m)"   # x86_64 or aarch64
bin="$HOME/.local/bin"
mkdir -p "$bin"

echo '==> apt packages'
sudo apt-get update -q
sudo apt-get install -y -q \
  zsh git curl unzip build-essential \
  fzf ripgrep fd-find bat eza zoxide git-delta

# Ubuntu names these batcat / fdfind
[ -e "$bin/bat" ] || ln -s "$(command -v batcat)" "$bin/bat"
[ -e "$bin/fd" ]  || ln -s "$(command -v fdfind)" "$bin/fd"

# Install a binary from a GitHub release tarball into ~/.local/bin
gh_release() { # <name> <url> <path inside tarball>
  command -v "$1" >/dev/null && return
  echo "==> $1"
  local tmp; tmp="$(mktemp -d)"
  curl -fsSL "$2" | tar xz -C "$tmp"
  install "$tmp/$3" "$bin/$1"
  rm -rf "$tmp"
}

# Neovim 0.11+ (the config uses vim.lsp.config; apt's version is too old)
if ! command -v nvim >/dev/null; then
  echo '==> neovim'
  rm -rf "$HOME/.local/nvim"
  mkdir -p "$HOME/.local/nvim"
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch/aarch64/arm64}.tar.gz" \
    | tar xz -C "$HOME/.local/nvim" --strip-components=1
  ln -sf "$HOME/.local/nvim/bin/nvim" "$bin/nvim"
fi

lg_ver="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": *"v\K[^"]*')"
gh_release lazygit \
  "https://github.com/jesseduffield/lazygit/releases/download/v${lg_ver}/lazygit_${lg_ver}_Linux_${arch/aarch64/arm64}.tar.gz" lazygit
gh_release zellij \
  "https://github.com/zellij-org/zellij/releases/latest/download/zellij-${arch}-unknown-linux-musl.tar.gz" zellij

if ! command -v starship >/dev/null; then
  echo '==> starship'
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$bin"
fi

# zsh plugin manager (used by ~/.config/zsh/zz-plugins.zsh)
[ -d "$HOME/.local/share/antidote" ] || \
  git clone -q --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.local/share/antidote"

echo '==> configs'
cp -r "$here/home/." "$HOME/"

# Git commit signing, only when an SSH key exists in WSL
if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
  printf '[user]\n\tsigningkey = ~/.ssh/id_ed25519.pub\n[gpg]\n\tformat = ssh\n[commit]\n\tgpgsign = true\n[tag]\n\tgpgsign = true\n' \
    > "$HOME/.config/git/signing"
else
  rm -f "$HOME/.config/git/signing"
  echo '    (no ~/.ssh/id_ed25519.pub: commit signing off)'
fi

if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$(command -v zsh)" ]; then
  echo '==> default shell: zsh'
  sudo chsh -s "$(command -v zsh)" "$USER"
fi

echo 'Done. Open a new Ubuntu tab to start zsh.'

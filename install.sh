#!/bin/bash
# install.sh

DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_REPO="https://github.com/neelbauman/dotfiles.git"

# 1. リポジトリをクローン (既にあれば pull)
if [ -d "$DOTFILES_DIR" ]; then
  cd "$DOTFILES_DIR" && git pull
else
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# 2. nvim の設定をリンク
mkdir -p "$HOME/.config"
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "Dotfiles setup via devcontainer CLI complete."

#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
#  DOTFILES SETUP SCRIPT
#  Automatically stows all packages in ~/.dotfiles/
#  Works on Linux (WSL) and macOS
# ------------------------------------------------------------

DOTFILES_DIR="$HOME/.dotfiles"
STOW_TARGET="$HOME"

# detect OS for nice feedback
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="macOS"
elif grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; then
  PLATFORM="WSL"
else
  PLATFORM="Linux"
fi

echo "🧩 Setting up dotfiles on $PLATFORM..."
echo "📁 Repo: $DOTFILES_DIR"
echo

# check dependencies
if ! command -v stow &>/dev/null; then
  echo "⚠️  GNU Stow not found. Installing..."
  if [[ "$PLATFORM" == "macOS" ]]; then
    brew install stow
  else
    sudo apt update && sudo apt install -y stow
  fi
fi

# cd into the repo
cd "$DOTFILES_DIR"

# loop through subfolders (e.g. zsh, tmux, nvim)
for dir in */; do
  # skip .git and non-directories
  [[ "$dir" == ".git/" ]] && continue
  [[ ! -d "$dir" ]] && continue

  echo "🔗 Stowing: ${dir%/}"
  stow -v --target="$STOW_TARGET" "${dir%/}"
done

echo
echo "✅ Dotfiles successfully stowed!"
echo "   You may need to restart your terminal for changes to take effect."

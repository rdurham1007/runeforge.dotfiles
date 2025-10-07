# ------------------------------------------------------------
# fzf-setup.zsh
# Auto-detect platform and set up fzf key bindings + completion
# for both macOS (Homebrew) and Linux/WSL
# ------------------------------------------------------------

# Exit if fzf is not installed
if ! command -v fzf &>/dev/null; then
  return
fi

# Detect platform
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="macOS"
elif grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; then
  PLATFORM="WSL"
else
  PLATFORM="Linux"
fi

# ------------------------------------------------------------
# macOS (Homebrew installs fzf under /opt/homebrew or /usr/local)
# ------------------------------------------------------------
if [[ "$PLATFORM" == "macOS" ]]; then
  if [[ -d "/opt/homebrew/opt/fzf" ]]; then
    FZF_PATH="/opt/homebrew/opt/fzf"
  elif [[ -d "/usr/local/opt/fzf" ]]; then
    FZF_PATH="/usr/local/opt/fzf"
  fi

  # If the install script was run, ~/.fzf.zsh should exist
  if [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
  elif [[ -n "$FZF_PATH" && -f "$FZF_PATH/shell/key-bindings.zsh" ]]; then
    source "$FZF_PATH/shell/completion.zsh"
    source "$FZF_PATH/shell/key-bindings.zsh"
  fi
fi

# ------------------------------------------------------------
# Linux / WSL
# ------------------------------------------------------------
if [[ "$PLATFORM" == "Linux" || "$PLATFORM" == "WSL" ]]; then
  # If installed via Homebrew on Linux
  if command -v brew &>/dev/null && [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]]; then
    FZF_PREFIX="$(brew --prefix)/opt/fzf"
    source "$FZF_PREFIX/shell/completion.zsh"
    source "$FZF_PREFIX/shell/key-bindings.zsh"

  # If installed via apt (common WSL/Ubuntu)
  elif [[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh

  # Fallback: user-installed fzf script
  elif [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
  fi
fi

# ------------------------------------------------------------
# Quality-of-life fzf settings
# ------------------------------------------------------------
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --bind 'ctrl-d:page-down,ctrl-u:page-up'
"

# Use ripgrep for default search if available
if command -v rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
else
  export FZF_DEFAULT_COMMAND='find . -type f 2>/dev/null'
fi

# Integration helpers
alias fzf-find='fzf --preview "bat --style=numbers --color=always {} 2>/dev/null | head -500"'
alias fzfh='history | fzf'

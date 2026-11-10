# Editor
export EDITOR=nvim
export VISUAL=nvim

# Pager
export PAGER=less

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

# Locale
export LANG=en_US.UTF-8

# Better defaults
export LESS="-R"

# PATH (~/.local/bin, .NET tools, nvm's node) is set in ~/.zshenv so
# non-interactive shells get it too.

# Qt apps: native Wayland
[[ $XDG_SESSION_TYPE == wayland ]] && export QT_QPA_PLATFORM=wayland

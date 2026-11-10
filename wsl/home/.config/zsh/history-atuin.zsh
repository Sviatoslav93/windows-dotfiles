# Atuin: searchable shell history on Ctrl+R (replaces fzf's Ctrl+R).
# Filename must sort after fzf.zsh so this binding wins.
# Up/Down stay with history-substring-search (zz-plugins.zsh).

command -v atuin >/dev/null || return 0

eval "$(atuin init zsh --disable-up-arrow)"

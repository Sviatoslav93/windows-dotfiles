# Antidote install location and plugin definitions.
antidote_home="$HOME/.local/share/antidote"
antidote_main="$antidote_home/antidote.zsh"
plugins_txt="$HOME/.config/zsh/plugins.txt"
plugins_bundle="$antidote_home/plugins.zsh"

# Load Antidote when installed; otherwise skip plugin setup quietly.
[[ -r "$antidote_main" ]] || return 0
source "$antidote_main"

# Keep the generated bundle out of dotfiles and refresh on first run or updates.
mkdir -p "$antidote_home"
if [[ ! -r "$plugins_bundle" || "$plugins_txt" -nt "$plugins_bundle" ]]; then
	antidote bundle < "$plugins_txt" >| "$plugins_bundle"
fi

source "$plugins_bundle"

# History substring search: Up/Down (normal and application cursor mode), Ctrl-P/N
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

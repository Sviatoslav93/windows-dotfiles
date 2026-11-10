# ~/.zshenv: sourced by EVERY zsh, including non-interactive ones (scripts,
# `zsh -c`, and the shells Claude Code and its MCP servers spawn). Keep it
# limited to PATH/env that tools need, and keep it fast. Interactive-only setup
# (aliases, prompt, plugins, the lazy `nvm` function) lives in ~/.config/zsh/.

# Drop duplicate PATH entries (nested shells would otherwise keep prepending)
typeset -U path

# Personal bin, .NET global tools
path=("$HOME/.local/bin" $path "$HOME/.dotnet/tools")

# Default nvm node on PATH without sourcing nvm.sh (~400ms). Without this,
# node/npx only exist in interactive shells and npx-based MCP servers
# (e.g. Playwright) fail with "npx not found".
export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR/versions/node" ]]; then
    _nvm_default=$(<"$NVM_DIR/alias/default") 2>/dev/null
    _nvm_bins=("$NVM_DIR"/versions/node/v${_nvm_default#v}*/bin(Nn))
    # Default alias isn't a plain version (e.g. lts/*): fall back to newest installed
    (( $#_nvm_bins )) || _nvm_bins=("$NVM_DIR"/versions/node/v*/bin(Nn))
    (( $#_nvm_bins )) && path=("$_nvm_bins[-1]" $path)
    unset _nvm_default _nvm_bins
fi

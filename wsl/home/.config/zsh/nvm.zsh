# nvm, lazy-loaded: sourcing nvm.sh costs ~400ms per shell. The default node
# is already on PATH via ~/.zshenv; nvm itself loads the first time `nvm` runs.
[[ -s "$NVM_DIR/nvm.sh" ]] || return 0

nvm() {
    unfunction nvm
    source "$NVM_DIR/nvm.sh" --no-use
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    nvm "$@"
}

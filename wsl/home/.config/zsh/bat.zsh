# bat aliases (Ubuntu ships it as `batcat`)

if (( $+commands[bat] )); then
    alias cat='bat'
    alias catp='bat --plain'
elif (( $+commands[batcat] )); then
    alias cat='batcat'
    alias catp='batcat --plain'
fi

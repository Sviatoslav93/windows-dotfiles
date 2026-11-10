# eza aliases
(( $+commands[eza] )) || return 0

alias ll='eza -lh --git'
alias la='eza -lah --git'
alias lt='eza --tree --level=2'
alias l='eza -1'

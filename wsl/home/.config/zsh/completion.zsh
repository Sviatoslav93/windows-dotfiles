autoload -Uz compinit

# Cache completions
mkdir -p ~/.cache/zsh

# zsh-completions only ships completion definitions, so it has to be on fpath
# before compinit runs (antidote just clones it, see plugins.txt).
fpath=(~/.cache/antidote/github.com/zsh-users/zsh-completions/src(N) $fpath)

compinit -d ~/.cache/zsh/zcompdump

# Bash-style completions (used by terraform and nvm's bash_completion)
autoload -U +X bashcompinit && bashcompinit
(( $+commands[terraform] )) && complete -o nospace -C $commands[terraform] terraform

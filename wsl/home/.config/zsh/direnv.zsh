# direnv: per-project env vars (API keys, tool versions) from an .envrc,
# loaded on cd and unloaded on leave. Run `direnv allow` once per .envrc.
command -v direnv >/dev/null || return 0

eval "$(direnv hook zsh)"

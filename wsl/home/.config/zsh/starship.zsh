command -v starship >/dev/null || return 0

eval "$(starship init zsh)"

# Transient prompt: after a command runs, collapse the fancy prompt down to
# plain text so past lines are easy to read/copy. The full prompt still
# shows while you're typing the next command.
autoload -Uz add-zsh-hook
add-zsh-hook precmd transient-prompt-precmd

TRANSIENT_PROMPT="${PROMPT// prompt / prompt --profile transient }"
TRANSIENT_RPROMPT="${PROMPT// prompt / prompt --profile rtransient }"

function transient-prompt-precmd {
    TRAPINT() { transient-prompt; return $(( 128 + $1 )) }
    SAVED_PROMPT="$(eval "printf '%s' \"${TRANSIENT_PROMPT}\"")"
    SAVED_RPROMPT="$(eval "printf '%s' \"${TRANSIENT_RPROMPT}\"")"
}

autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-finish transient-prompt

function transient-prompt() {
    PROMPT="$SAVED_PROMPT" RPROMPT="$SAVED_RPROMPT" zle .reset-prompt
}

# Separate each command's block (prompt + output) from the next with a
# blank line
# prompt of a new shell.
function _prompt_separator_precmd() {
    if [[ -n $_PROMPT_SEPARATOR_SHOWN ]]; then
        print
    fi
    _PROMPT_SEPARATOR_SHOWN=1
}
add-zsh-hook precmd _prompt_separator_precmd

# `clear` finishing a command cycle would otherwise trigger the separator
# blank line above on the next prompt, landing it one row lower than Ctrl+L
# (which redraws in place via ZLE without re-running precmd).
function clear() {
    command clear
    unset _PROMPT_SEPARATOR_SHOWN
}

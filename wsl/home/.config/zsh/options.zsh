# History
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

# Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Completion
setopt COMPLETE_IN_WORD

# Globbing
setopt EXTENDED_GLOB

# Nice shell
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# Line editing (explicit: EDITOR=nvim would otherwise auto-select vi keymap)
bindkey -e

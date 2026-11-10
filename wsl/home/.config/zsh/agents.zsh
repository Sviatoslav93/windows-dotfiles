# Claude Code helpers. Not `cc` (that's the C compiler).
command -v claude >/dev/null || return 0

alias cl='claude'
alias clc='claude --continue'
alias clr='claude --resume'

# Path of the main (non-linked) worktree of the current repo, so the helpers
# below behave the same when run from inside a linked worktree.
_cw_main() {
    local common
    common=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || {
        echo "not in a git repository" >&2
        return 1
    }
    print -r -- "${common:h}"
}

# cw <branch> [claude args...]: open (creating if needed) a sibling worktree
# ../<repo>-<branch> on <branch> and start Claude in it, so several agents can
# work in parallel without touching the main checkout.
cw() {
    (( $# )) || { echo "usage: cw <branch> [claude args...]" >&2; return 1; }
    local branch=$1; shift
    local main dir
    main=$(_cw_main) || return
    dir="${main:h}/${main:t}-${branch//\//-}"

    if [[ ! -d $dir ]]; then
        if git -C "$main" show-ref --verify --quiet "refs/heads/$branch"; then
            git -C "$main" worktree add "$dir" "$branch"
        else
            git -C "$main" worktree add -b "$branch" "$dir"
        fi || return
    fi
    cd "$dir" && claude "$@"
}

# cwrm [branch]: remove the worktree for <branch>, or the current one.
# Refuses on uncommitted changes (no --force) and keeps the branch itself.
cwrm() {
    local main dir
    main=$(_cw_main) || return
    if (( $# )); then
        dir="${main:h}/${main:t}-${1//\//-}"
    else
        dir=$(git rev-parse --show-toplevel) || return
    fi
    if [[ $dir == "$main" ]]; then
        echo "cwrm: refusing to remove the main worktree" >&2
        return 1
    fi
    [[ $PWD/ == "$dir"/* ]] && cd "$main"
    git -C "$main" worktree remove "$dir"
}

alias cwl='git worktree list'

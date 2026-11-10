mkcd() {
    mkdir -p "$1"
    cd "$1"
}

extract() {
    if [[ ! -f "$1" ]]; then
        echo "extract: '$1' is not a file" >&2
        return 1
    fi
    case "$1" in
        *.tar|*.tar.*|*.tgz|*.tbz2|*.txz) tar -xf "$1" ;;
        *.zip) unzip "$1" ;;
        *.gz) gunzip -k "$1" ;;
        *.bz2) bunzip2 -k "$1" ;;
        *.xz) unxz -k "$1" ;;
        *.7z) 7z x "$1" ;;
        *) echo "extract: unknown archive format: $1" >&2; return 1 ;;
    esac
}

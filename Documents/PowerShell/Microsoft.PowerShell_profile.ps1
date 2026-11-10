# PowerShell 7 profile (managed by chezmoi: edit in D:\windows-dotfiles, then `chezmoi apply`)

function Test-Cmd([string]$Name) { [bool](Get-Command $Name -ErrorAction SilentlyContinue) }

# --- Environment -------------------------------------------------------------
$env:EDITOR = 'nvim'
$env:VISUAL = 'nvim'
$env:LESS = '-R'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- PSReadLine --------------------------------------------------------------
Set-PSReadLineOption -EditMode Emacs -HistoryNoDuplicates -MaximumHistoryCount 100000 -BellStyle None
# Predictions need a real terminal; skip them when output is redirected (scripts, CI, agents).
if (-not [Console]::IsOutputRedirected) {
    Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
}
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# --- Navigation --------------------------------------------------------------
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function mkcd([string]$Path) { New-Item -ItemType Directory -Force $Path | Out-Null; Set-Location $Path }

# --- Git (replace built-in gc/gp/gl aliases) ---------------------------------
foreach ($a in 'gc', 'gp', 'gl') { Remove-Item "Alias:$a" -Force -ErrorAction SilentlyContinue }
function gs { git status @args }
function ga { git add @args }
function gc { git commit @args }
function gp { git push @args }
function gl { git pull @args }

# --- ls (eza) ----------------------------------------------------------------
if (Test-Cmd eza) {
    function ll { eza -lh --git --icons @args }
    function la { eza -lah --git --icons @args }
    function lt { eza --tree --level=2 --icons @args }
    function l { eza -1 --icons @args }
} else {
    function ll { Get-ChildItem @args }
    function la { Get-ChildItem -Force @args }
}

# --- cat (bat) ---------------------------------------------------------------
if (Test-Cmd bat) {
    Remove-Item Alias:cat -Force -ErrorAction SilentlyContinue
    function cat { bat @args }
    function catp { bat --plain @args }
}

# --- Misc --------------------------------------------------------------------
function reload { . $PROFILE }

function extract([string]$File) {
    if (-not (Test-Path $File -PathType Leaf)) { Write-Error "extract: '$File' is not a file"; return }
    switch -Regex ($File) {
        '\.(tar|tar\..+|tgz|tbz2|txz|zip)$' { tar -xf $File; break }
        '\.(7z|rar|gz|bz2|xz)$' { 7z x $File; break }
        default { Write-Error "extract: unknown archive format: $File" }
    }
}

# --- Tools -------------------------------------------------------------------
# fzf: Ctrl+T files, Ctrl+R history
try {
    Import-Module PSFzf -ErrorAction Stop
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
} catch {}

if (Test-Cmd starship) { Invoke-Expression (& starship init powershell | Out-String) }
if (Test-Cmd zoxide) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }

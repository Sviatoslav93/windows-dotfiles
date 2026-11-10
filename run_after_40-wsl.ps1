# Install WSL 2 with Ubuntu. Runs on every apply but exits early once a distro exists.
# On a fresh PC the first run only enables the VM feature; after the reboot, the
# next `chezmoi apply` installs Ubuntu itself.

$distros = (wsl.exe -l -q 2>$null) -replace "`0", '' | Where-Object { $_.Trim() }
if ($LASTEXITCODE -eq 0 -and $distros) {
    Write-Host "WSL: already installed ($($distros -join ', '))"
    exit 0
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host 'WSL: skipped (run `chezmoi apply` from an admin shell, or run `wsl --install -d Ubuntu`)'
    exit 0
}

Write-Host 'WSL: installing WSL 2 + Ubuntu'
wsl.exe --install -d Ubuntu --no-launch
if ($LASTEXITCODE -eq 0) {
    Write-Host 'WSL: done. If Ubuntu is not listed yet, reboot and run `chezmoi apply` again (see README > WSL).'
} else {
    Write-Host "WSL: install failed (exit $LASTEXITCODE); run 'wsl --install -d Ubuntu' manually"
}
exit 0

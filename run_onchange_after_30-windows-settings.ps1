# Windows settings. chezmoi re-runs this whenever the file changes.

$adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Write-Host 'Explorer: show file extensions and hidden files'
Set-ItemProperty -Path $adv -Name HideFileExt -Value 0 -Type DWord
Set-ItemProperty -Path $adv -Name Hidden -Value 1 -Type DWord

# Developer Mode (symlinks without admin, sideloading). Needs an elevated shell.
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)
$unlock = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
$devMode = (Get-ItemProperty -Path $unlock -Name AllowDevelopmentWithoutDevLicense -ErrorAction SilentlyContinue).AllowDevelopmentWithoutDevLicense
if ($devMode -eq 1) {
    Write-Host 'Developer Mode: already on'
} elseif ($isAdmin) {
    Write-Host 'Developer Mode: turning on'
    if (-not (Test-Path $unlock)) { New-Item -Path $unlock -Force | Out-Null }
    Set-ItemProperty -Path $unlock -Name AllowDevelopmentWithoutDevLicense -Value 1 -Type DWord
} else {
    Write-Host 'Developer Mode: skipped (run `chezmoi apply` from an admin shell, or turn it on in Settings > System > For developers)'
}
exit 0

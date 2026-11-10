# PowerShell modules used by the profile.
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
foreach ($m in 'PSFzf') {
    if (-not (Get-Module -ListAvailable -Name $m)) {
        Write-Host "Installing module $m"
        Install-Module -Name $m -Scope CurrentUser -Force
    }
}

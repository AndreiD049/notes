$config = Get-Content ".wikirc.json" | ConvertFrom-Json
Set-Location (Get-Item $PSScriptRoot).Parent.FullName

try {
    & git.exe --version | Out-Null;
    $git_installed = $true;
}
catch {
    $git_installed = $false;
}

if ($git_installed) {
    do {
        powershell -File ./scripts/sync.ps1 -Name $config.remoteName -Branch $config.remoteBranch
        Start-Sleep -Seconds ($config.syncInterval * 60)
    } until ($infinity)
} else {
    Write-Error "Git not installed";
}
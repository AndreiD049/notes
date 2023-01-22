param ($Interval=10)

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
        Start-Sleep -Seconds 20
        & powershell -File ./scripts/sync.ps1
    } until ($infinity)
} else {
    Write-Error "Git not installed";
}
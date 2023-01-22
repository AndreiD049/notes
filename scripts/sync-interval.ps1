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
        powershell -File ./scripts/sync.ps1
        Start-Sleep -Milliseconds 100000
    } until ($infinity)
} else {
    Write-Error "Git not installed";
}
param ($Interval=10,$Name,$Branch)

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
        powershell -File ./scripts/sync.ps1 -Name $Name -Branch $Branch
        Start-Sleep -Seconds $Interval
    } until ($infinity)
} else {
    Write-Error "Git not installed";
}
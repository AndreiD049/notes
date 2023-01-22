Set-Location (Get-Item $PSScriptRoot).Parent.FullName

$log_file = "./sync-log.txt"
if (-not (Test-Path $log_file)) {
    New-Item $log_file
}

$status = git.exe status
Add-Content $log_file "Synchronizing: $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")"
if (-not ($status -match "nothing to commit")) { 
    Add-Content $log_file $status
    $commit_message = "Wiki sync. $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")"
    $added = git.exe add .
    Add-Content -Path $log_file $added
    $commit = git.exe commit -m $commit_message 
    Add-Content -Path $log_file $commit
} else {
    Add-Content $log_file "Nothing to commit";
}
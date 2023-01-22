Set-Location (Get-Item $PSScriptRoot).Parent.FullName

$status = git.exe status
$log_file = "./synclog.txt"
Add-Content $log_file "Synchronizing: $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")"
if (-not ($status -match "nothing to commit")) { 
    $status | Add-Content $log_file
    $commit_message = "Wiki sync. $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")"
    & git.exe add . | Add-Content $log_file
    & git.exe commit -m $commit_message | Add-Content $log_file
} else {
    Write-Output "Nothing to commit";
}
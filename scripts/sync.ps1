$status = git.exe status
if (-not ($status -match "nothing to commit")) {
    Write-Output $status
    $commit_message = "Wiki sync. $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")"
    & git.exe add .
    & git.exe commit -m $commit_message
} else {
    Write-Output "Nothing to commit";
}
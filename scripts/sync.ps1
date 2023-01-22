$status = git.exe status
Write-Output $status
if (-not ($status -match "nothing to commit")) {
    Write-Output "Something to commit"
}
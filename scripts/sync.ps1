Set-Location (Get-Item $PSScriptRoot).Parent.FullName

$status = git.exe status
if (-not ($status -match "nothing to commit")) { 
    $status > "./synclog.txt"
    $commit_message = "Wiki sync. $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")"
    & git.exe add . > "./synclog.txt"
    & git.exe commit -m $commit_message > "./synclog.txt"
} else {
    Write-Output "Nothing to commit";
}
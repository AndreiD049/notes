param ($Name,$Url)

$remote_exists = git.exe remote -v

if (($remote_exists | Where-Object { $_ -match $Name}).Count -eq 0) {
    Write-Output "Remote with name $Name not found. Adding...";
    & git.exe remote add $Name $Url;
} elseif (($remote_exists | Where-Object { $_ -match "$Name.*$Url"}).Count -eq 0) {
    Write-Output "Remove old remote $Name";
    & git.exe remote remove $Name;
    Write-Output "Add new remote $Name";
    & git.exe remote add $Name $Url;
}
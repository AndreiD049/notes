param ($WikiName="Default",$Port=3000,$NoBrowser=$false)

$location = (Get-Item $PSScriptRoot).Parent.FullName
Set-Location $location
$npx_executable = "./temp/node/npx";
$config = Get-Content ".wikirc.json" | ConvertFrom-Json
$wiki_path = "./data/$($config.wikiname)";
$sync_script = (Get-Item "./scripts/sync-interval.ps1").FullName

& powershell.exe "./scripts/check-remote.ps1" -Name $config.remoteName -Url $config.remoteUrl

if (-not (Test-Path $wiki_path)) {
    & $npx_executable tiddlywiki $wiki_path --init server
}

if ($NoBrowser -eq $false) {
    Start-Process "http://127.0.0.1:$Port"
} 

Write-Output $config.syncInterval

if ($config.sync) {
    Start-Job -ScriptBlock {
        powershell.exe -File $using:sync_script -Interval $using:config.syncInterval -Name $using:config.remoteName -Branch $using:config.remoteBranch;
    }
}
& $npx_executable tiddlywiki $wiki_path --listen port=$Port

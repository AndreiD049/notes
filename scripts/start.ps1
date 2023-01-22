param ($WikiName="Default",$Port=3000,$NoBrowser=$false)

Set-Location (Get-Item $PSScriptRoot).Parent.FullName
$npx_executable = "./temp/node/npx";
$config = Get-Content ".wikirc.json" | ConvertFrom-Json
$wiki_path = "./data/$($config.wikiname)";

& powershell.exe "./scripts/check-remote.ps1" -Name $config.remoteName -Url $config.remoteUrl

if (-not (Test-Path $wiki_path)) {
    & $npx_executable tiddlywiki $wiki_path --init server
}

if ($NoBrowser -eq $false) {
    Start-Process "http://127.0.0.1:$Port"
} 
if ($config.sync) {
    $sync_job = Start-Job -ScriptBlock {
        & powershell.exe -File "./scripts/sync-interval.ps1" -Name $config.remoteName -Branch $config.remoteBranch
    } -InitializationScript { Set-Location "." }
}
& $npx_executable tiddlywiki $wiki_path --listen port=$Port
Write-Output "remove"
$sync_job | Receive-Job -Wait -AutoRemoveJob

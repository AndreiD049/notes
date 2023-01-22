param ($WikiName="Default",$NoBrowser=$false)

Set-Location (Get-Item $PSScriptRoot).Parent.FullName
$npx_executable = "./temp/node/npx";
$config = Get-Content ".wikirc.json" | ConvertFrom-Json
$wiki_path = "./data/$($config.wikiname)";

if (-not (Test-Path $wiki_path)) {
    & $npx_executable tiddlywiki $wiki_path --init server
}

# & powershell.exe -File ./scripts/sync.ps1

if ($NoBrowser -eq $false) {
    Start-Process "http://127.0.0.1:8080"
} 
if ($config.sync) {
    $sync_job = Start-Job -ScriptBlock {
        & powershell.exe -File "./scripts/sync-interval.ps1"
    } -InitializationScript { Set-Location "D:\Development\js\npm\tiddlywiki-cmd" }
}
$server = Start-Job -ScriptBlock { & $npx_executable tiddlywiki $wiki_path --listen }
$server | Receive-Job -Wait -AutoRemoveJob
$sync_job | Receive-Job -Wait -AutoRemoveJob

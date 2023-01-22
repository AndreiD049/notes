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
if ($config.sync) {
    Start-Job -ScriptBlock {
        param ($Script,$Name,$Branch)

        powershell.exe -File $Script -Name $Name -Branch $Branch;
    } -Arg $sync_script, $config.remoteName, $config.remoteBranch
}
& $npx_executable tiddlywiki $wiki_path --listen port=$Port

param ($Name,$Branch)
Set-Location (Get-Item $PSScriptRoot).Parent.FullName;

$npx_executable = "./temp/node/npx";
$log_file = "./sync-log.txt";
if (-not (Test-Path $log_file)) {
    New-Item $log_file;
}

try {
    git.exe pull $Name $Branch
} catch {}

$status = git.exe status;
Add-Content $log_file "Synchronizing: $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")"
if (-not ($status -match "nothing to commit")) { 
    & $npx_executable tiddlywiki ./data/Default --build index
    Move-Item "./data/Default/output/index.html" -Destination "./docs/" -Force
    $commit_message = "Wiki sync. $(Get-Date -Format "yyyy-MM-ddThh:mm:ss")";
    $added = git.exe add .;
    Add-Content -Path $log_file $added;
    $commit = git.exe commit -m $commit_message ;
    Add-Content -Path $log_file $commit;
    $push = git.exe push $Name $Branch;
    Add-Content -Path $log_file $push;
} else {
    Add-Content $log_file "Nothing to commit";
}
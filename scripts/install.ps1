$node_version_to_install = "v18.13.0";
$node_file_to_install = "node-$node_version_to_install-win-x64";

Set-Location $PSScriptRoot

Remove-Item "../temp/node" -Recurse -Force -ErrorAction Ignore | Out-Null;

$npm_executable = "../temp/node/npm.cmd";

try {
    $node_version = node.exe --version;
    Write-Output "node.js version $node_version already installed";
    
    # create symlink for node
    New-Item -ItemType Directory -Path "../temp/node" -ErrorAction Ignore -Force | Out-Null;
    $node_installed_executable = (Get-Command node.exe).Path
    New-Item -ItemType Junction -Path "../temp/node" -Target (Get-Item $node_installed_executable).Directory.FullName | Out-Null;
} catch {
    # install node
    Write-Output "Installing node.js";
    
    Invoke-WebRequest -Uri "https://nodejs.org/dist/$node_version_to_install/$node_file_to_install.zip" -OutFile "../temp/node_temp.zip"
    
    Expand-Archive "../temp/node_temp.zip" -DestinationPath "../temp" -Force;
    Rename-Item "../temp/$node_file_to_install" -NewName "node";
}

# install tiddlywiki
& $npm_executable install

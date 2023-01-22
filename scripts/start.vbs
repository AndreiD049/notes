Set objShell = CreateObject("Wscript.shell")
scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
objShell.run("powershell -windowstyle hidden -file " & scriptdir & "/start.ps1 -NoBrowser $true")

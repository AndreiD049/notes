Set objShell = CreateObject("Wscript.shell")
scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
MsgBox scriptdir
objShell.run("powershell -windowstyle hidden -file " & scriptdir & "/start.ps1")

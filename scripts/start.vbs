Set objShell = CreateObject("Wscript.shell")
scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
MsgBox scriptdir
objShell.run("powershell -noexit -file " & scriptdir & "/start.ps1 -windowstyle hidden")

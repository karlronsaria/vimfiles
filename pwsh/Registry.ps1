#Requires -RunAsAdministrator

. "$PsScriptRoot\..\external\Registry.ps1"

Param(
    [String]
    $Path
)

Open-Registry $Path

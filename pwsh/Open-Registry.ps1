#Requires -RunAsAdministrator

<#
.DESCRIPTION
Requires regjump.

.LINK
Url: https://learn.microsoft.com/en-us/sysinternals/downloads/regjump
Retrieved: 2023-02-02
#>
Param(
    [String]
    $Path
)

. "$PsScriptRoot\external\Registry.ps1"
Open-Registry $Path

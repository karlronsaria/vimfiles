<#
.SYNOPSIS
Open the regedit at the specified path similar to sysinternals regjump.

.DESCRIPTION
Opens regedit at the specified path accepts multiple paths provided as argument or from the clipboard (if no argument provided). Registry paths can contain leading abbreviated hive names (e.g. HKLM, HKCU) or PowerShell paths (e.g. HKLM:\). If the path does not represent an existing key withn the registry the path is shortened one level until a valid path is found (warning is displayed if no part of the path is found).

.PARAMETER Key
A string or a string array representing one or more registry paths. The paths can contain leading abbreviated hive names like HKLM:, HKLM:\, HKCU:...

.EXAMPLE
# The example opens multiple instances of regedit with at the specified paths via an argument to the Key paramater

$testKeys =@'
HKLM\Software\Microsoft\Outlook Express
HKLM\Software\Microsoft\PowerShell
HKLM\Software\Microsoft\Windows
'@ -split "`r`n"
Open-Registry $testKeys

.EXAMPLE
# The example demonstrates the use case if the keys are in the clipboard

@'
HKLM\Software\Microsoft\Outlook Express
HKLM\Software\Microsoft\PowerShell
HKLM\Software\Microsoft\Windows
'@ -split "`r`n" | clip
Open-Registry

.EXAMPLE
# The example will open regedit with the run key open as the last part of the path does not represent a key

Open-Registry HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\skype

.EXAMPLE
# The example provides an invalid path to the function (using the alias) resulting in a warning message and no instance of regedit opening

regJump HKLMm\xxxxx

.LINK
Url: https://github.com/DBremen/PowerShellScripts/blob/master/Utils/Open-Registry.ps1
Retrieved: 2023_02_02
#>
function Open-Registry {
    [CmdletBinding()]
    [Alias("regJump")]
    Param(
        [Parameter(Position = 0)]
        [String[]]
        $Key
    )

    # Check Clipboard if no argument provided
    if (-not $Key) {
        # Split the Clipboard content by crlf and get of trailing crlf in
        # case Clipboard populated via piping it to clip.exe
        $cmd = {
            Add-Type -Assembly PresentationCore
            [Windows.Clipboard]::GetText() -split "`r`n" | where { $_ }
        }

        # In case this cmdlet run from the powershell commandline
        $Key = if ([Threading.Thread]::CurrentThread.GetApartmentState() -eq 'MTA') {
            & powershell -STA -Command $cmd
        }
        else {
            & $cmd
        }
    }

    foreach ($keySubitem in $Key) {
        $replacers = @{
            'HKCU' = 'HKEY_CURRENT_USER'
            'HKLM' = 'HKEY_LOCAL_MACHINE'
            'HKU'  = 'HKEY_USERS'
            'HKCC' = 'HKEY_CURRENT_CONFIG'
            'HKCR' = 'HKEY_CLASSES_ROOT'
        }

        # Replace hive shortnames with PowerShell syntax
        $properKey = $keySubitem

        $replacers.GetEnumerator() | foreach {
            $properKey = $properKey.ToUpper() -replace "$($_.Key):?\\", "$($_.Value)\"
        }

        # Check if the path points to an existing key or its parent
        # is an existing value. Add one level, since we don't want
        # the first iteration of the loop to remove a level
        $path = Join-Path $properKey 'dummyFolder'

        # Test the registry path and revert to parent path until a
        # valid path is found. Otherwise, return False
        while ((Split-Path $path -OutVariable 'path') -and -not (Test-Path "Registry::$path")) {}

        if (-not $path) {
            Write-Output "Neither ""$keySubitem"" nor any of its parents exist"
            return
        }

        Set-ItemProperty `
            -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\' `
            -Name 'LastKey' `
            -Value $path `
            -Force

        # Start regedit using M-switch to allow for multiple instances
        $regeditInstance = [Diagnostics.Process]::Start("regedit", "-m")

        # Wait for the regedit window to appear
        while ($regeditInstance.MainWindowHandle -eq 0) {
            Start-Sleep -Milliseconds 100
        }
    }
}


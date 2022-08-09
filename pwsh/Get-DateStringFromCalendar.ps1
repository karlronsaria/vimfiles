$result = & $PsScriptRoot\DateString_WpfCalendar.ps1

if ($result.Success -and $result.Print) {
    return $result.Date
}


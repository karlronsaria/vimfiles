Param(
    [String]
    $Path
)

if ($Path) {
    Start-Process `
        -FilePath 'powershell' `
        -ArgumentList @(
            "-NoExit",
            "-Command",
            """Set-Location $Path"""
        )

    return
}

Start-Process `
    -FilePath 'powershell' `
    -ArgumentList "-NoExit"

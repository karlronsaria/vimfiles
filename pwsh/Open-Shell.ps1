Param(
    [String]
    $Path
)

if ($Path) {
    # (karlr 2025-02-13)
    # Change 'powershell' to 'pwsh'
    Start-Process `
        -FilePath 'pwsh' `
        -ArgumentList @(
            "-NoExit",
            "-Command",
            """Set-Location $Path"""
        )

    return
}

# (karlr 2025-02-13)
# Change 'powershell' to 'pwsh'
Start-Process `
    -FilePath 'pwsh' `
    -ArgumentList "-NoExit"


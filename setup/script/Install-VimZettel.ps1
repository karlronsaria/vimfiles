$packages = @(
    'ripgrep'
    'universal-ctags'
)

$noteDirVariable = @{
    Name = 'note_dir'
    Value = 'C:\note'
}

$zettelSubdir =
    'zettel'

$zettelItems = @(
    '..\res\.ctags.d'
)

iex "choco install $($packages -join ' ') -y"

[System.Environment]::SetEnvironmentVariable(
    $noteDirVariable.Name,
    $noteDirVariable.Value,
    'Machine'
)

$zettelPath = Join-Path $noteDirVariable.Value $zettelSubdir

foreach ($item in $zettelItems) {
    Copy-Item `
        -Path (Join-Path $PsScriptRoot $item) `
        -Destination $zettelPath `
        -Recurse `
        -Force
}



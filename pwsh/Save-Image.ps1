Param(
    [String]
    $BasePath
)

. $PsScriptRoot\PsMarkdown\script\Other.ps1
. $PsScriptRoot\PsMarkdown\script\ClipImage.ps1

if (-not $BasePath) {
    $BasePath = (Get-Location).Path
}

$capture = Save-ClipboardToImageFormat `
    -BasePath $BasePath `
    -ErrorAction SilentlyContinue

return $capture | where {
    $_.Success
} | foreach {
    $_.MarkdownString
}


. $PsScriptRoot\PsMarkdown\script\ClipImage.ps1

$capture = Save-ClipboardToImageFormat `
    -BasePath (Get-Location).Path `
    -ErrorAction SilentlyContinue

return $capture | where {
    $_.Success
} | foreach {
    $_.MarkdownString
}

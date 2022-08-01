. $PsScriptRoot\ClipImage.ps1

$capture = Save-ClipboardToImageFormat `
    -BasePath (Get-Location).Path `
    -ErrorAction SilentlyContinue

if ($capture.Success) {
    return $capture.MarkdownString
}


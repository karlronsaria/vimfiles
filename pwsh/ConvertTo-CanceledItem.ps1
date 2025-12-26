Param(
    [Parameter(ValueFromPipeline)]
    $InputString
)

Begin {
    . $PsScriptRoot\PsMarkdown\demand\Worklist.ps1
}

Process {
    return ConvertTo-MarkdownCanceledItem -InputString $InputString
}


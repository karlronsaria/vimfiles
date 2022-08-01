:function TestWorkingDirectory(function_name)
:  let l:current_file_path = expand('%:p')
:  if l:current_file_path == ""
:    echom a:function_name . ": Current file path not found"
:    return 0
:  endif
:  let l:systemroot = trim(system("echo %systemroot%"))
:  if stridx(l:current_file_path, l:systemroot) > -1
:    echom a:function_name . ": The editor working directory is "
       \ . l:current_file_path . "; the function cannot be called
       \ at this location"
:    return 0
:  endif
:  let l:cmd_wd = trim(system("cd"))
:  if stridx(l:cmd_wd, l:systemroot) > -1
:    echom a:function . ": The system working directory is "
       \ . l:cmd_wd . "; the function cannot be called
       \ at this location"
:    return 0
:  endif
:  return 1
:endfunction

" Requires: powershell cmdlet:Save-ClipboardToImageFormat
" Location: 
"   C:\devlib\powershell\Shortcut.ps1
"   C:\devlib\powershell\PsMarkdown\*
:function SaveImage()
:  let l:fname = "SaveImage"
:  if !TestWorkingDirectory(l:fname)
:    return
:  endif
:  let g:vim_home = get(g:, 'vim_home', expand('~/.vim/'))
:  let l:pwsh_cmd = g:vim_home . "/pwsh/Save-Image.ps1"
:  echo l:fname . ": Running PowerShell..."
:  echo trim(execute(":r ! powershell -Command \"" . l:pwsh_cmd . "\""))
:  call feedkeys("\<CR>o\<ESC>")
:endfunction

" Requires: powershell cmdlet:Move-ToTrashFolder
" Location: 
"   C:\devlib\powershell\Shortcut.ps1
"   C:\devlib\powershell\PsMarkdown\*
:function RemoveImage()
:  let l:fname = "RemoveImage"
:  if !TestWorkingDirectory(l:fname)
:    return
:  endif
:  let l:pattern = '\v\(\zs\w*\/(\w+\/)+\d+(_\d+){3}\.\w+\ze\)'
:  let l:capture = matchstr(getline('.'), l:pattern)
:  let l:pwsh_cmd =
     \ "Move-ToTrashFolder -Path '" . l:capture . "' -TrashFolder '__OLD'"
:  if l:capture != ""
:    call feedkeys("dd")
:    echo l:fname . ": Running PowerShell..."
:    echo trim(execute("! powershell -Command \"" . l:pwsh_cmd . "\""))
:  else
:    echom l:fname . ": Pattern not found"
:  endif
:endfunction

:command Img :call SaveImage()
:command Rimg :call RemoveImage()
" :command Test :echom TestWorkingDirectory("Test")


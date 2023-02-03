require('define')
require('run')

-- @param functionName string
-- @return 0|1
function TestWorkingDir(functionName)
    local currentFilePath = vim.fn.expand('%:p')

    if currentFilePath == '' then
        print(functionName .. ': Current file path not found')
        return 0
    end

    local systemroot = trim(system('echo %systemroot%'))

    if string.find(currentFilePath, systemroot) then
        print(
            functionName ..
            ': The editor working directory is ' ..
            currentFilePath ..
            '; the function cannot be called at this location'
        )

        return 0
    end

    local cmdWd = trim(system('cd'))

    if string.find(cmdWd, systemroot) then
        print(
            functionName ..
            ': The editor working directory is ' ..
            cmdWd ..
            '; the function cannot be called at this location'
        )

        return 0
    end

    return 1
end

-- Requires: powershell cmdlet:Save-ClipboardToImageFormat
-- Location:
--   C:\devlib\powershell\Shortcut.ps1
--   C:\devlib\powershell\PsMarkdown\*
-- @return void
function SaveImage()
    local fname = 'SaveImage'

    if not TestWorkingDir(fname) then
        return
    end

    local pwshCmd = script_path() .. 'nvim/pwsh/Save-Image.ps1'
    print(fname .. ': Running PowerShell...')
    vim.api.nvim_put({ ToSingleLine(RunPowerShell(pwshCmd), '') }, 'c', true, true)
    vim.cmd('normal o')
end

-- Requires: powershell cmdlet:Move-ToTrashFolder
-- Location:
--   C:\devlib\powershell\Shortcut.ps1
--   C:\devlib\powershell\PsMarkdown\*
-- @return void
function RemoveImage()
    local fname = 'RemoveImage'

    if not TestWorkingDir(fname) then
        return
    end

    local pattern = [[\v\(\zs\w*\/(\w+\/)+\d+(_\d+){3}\.\w+\ze\)]]
    local capture = string.match(vim.fn.getline('.'), pattern)

    if capture == nil then
        print(fname .. ': Pattern not found')
        return
    end

    -- TODO
    local pwshCmd =
        "Move-ToTrashFolder -Path '" .. capture .. "' -TrashFolder '__OLD'"

    -- delete line under cursor
    replace_current_line({})
    print(fname .. ': Running PowerShell...')
    vim.api.nvim_put({ ToSingleLine(RunPowerShell(pwshCmd), '') }, 'c', true, true)
end

vim.api.nvim_create_user_command(
  'Img',
  function() SaveImage() end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'Rimg',
  function() RemoveImage() end,
  { nargs = 0 }
)

-- vim.api.nvim_create_user_command(
--   'Test',
--   function() TestWorkingDir('Test') end,
--   { nargs = 0 }
-- )


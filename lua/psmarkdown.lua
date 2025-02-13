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

-- (karlr 2024_10_10)
-- Requires: powershell cmdlet:ConvertTo-MarkdownCanceledItem
-- Location:
--   C:\devlib\powershell\WorkList.ps1
--   C:\devlib\powershell\PsMarkdown\*
-- @return void
function CancelItem(line)
    local fname = 'CancelName'

    local pwshCmd = script_path()
        .. 'pwsh/ConvertTo-CanceledItem.ps1 -InputString '
        .. [[']] .. line .. [[']]

    return RunPowerShellNoProfile(pwshCmd)
end

function CancelItemOnLine(line_num)
    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, CancelItem(line))
end

function CancelItemsInSelection()
    local start_pos = vim.fn.getpos("'<")[2] -- start line
    local end_pos = vim.fn.getpos("'>")[2] -- end line

    for line_num = start_pos, end_pos do
        CancelItemOnLine(line_num)
    end
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

    local pwshCmd = script_path() .. 'pwsh/Save-Image.ps1'
    print(fname .. ': Running PowerShell...')
    vim.api.nvim_put(RunPowerShellNoProfile(pwshCmd), 'c', true, true)
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

    local pattern = [[\v\(\zs\w*\/(\w+\/)+\d+(_\d+){3}\.\w+\ze\)]] -- Uses DateTimeFormat
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
    vim.api.nvim_put({ Join('', RunPowerShellNoProfile(pwshCmd)) }, 'c', true, true)
end

vim.api.nvim_create_user_command(
  'Img',
  SaveImage,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'Rimg',
  RemoveImage,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'Strike',
  function()
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    CancelItemOnLine(line_num)
  end,
  { nargs = 0, range = false }
)

vim.api.nvim_create_user_command(
  'StrikeAll',
  CancelItemsInSelection,
  { nargs = 0, range = true }
)


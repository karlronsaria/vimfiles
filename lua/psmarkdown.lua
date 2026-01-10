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

-- (karlr 2024-10-10)
-- Requires: powershell cmdlet:ConvertTo-MarkdownCanceledItem
-- Location:
--   C:\devlib\powershell\WorkList.ps1
--   C:\devlib\powershell\PsMarkdown\*
-- @return void
function ReplaceWithCanceledItem(start_pos, end_pos)
    local inputs = {}

    for line_num = start_pos, end_pos do
        local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
        line = [[']] .. line:gsub([[']], [['']]):gsub([["]], [[\"]]) .. [[']]
        table.insert(inputs, line)
    end

    local inputStr = table.concat(inputs, ", ")

    local pwshCmd = inputStr
        .. ' | '
        .. script_path()
        .. 'pwsh/ConvertTo-CanceledItem.ps1'

    local outputs = RunPowerShellNoProfile(pwshCmd)
    vim.api.nvim_buf_set_lines(0, start_pos - 1, end_pos, false, outputs)
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

    local currentFilePath = vim.fn.expand('%:p:h')
    local pwshCmd = script_path() .. 'pwsh/Save-Image.ps1 -BasePath "' .. currentFilePath .. '"'
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

    local pattern = [[\v\(\zs\w*\/(\w+\/)+\d+(-\d+){3}\.\w+\ze\)]] -- Uses DateTimeFormat
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
  function(opts)
    return ReplaceWithCanceledItem(opts.line1, opts.line2)
  end,
  { nargs = 0, range = true }
)


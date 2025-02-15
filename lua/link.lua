require('define')
require('run')

function GetLinkTable(line)
    local myTable = {}

    local ext = vim.bo.filetype
    local pattern = ".*"

    if ext == 'markdown' then
        pattern = "[^()\"]+"
    elseif ext == 'json' then
        -- pattern = "\"[^\"]+\"(,|})?%s*$"
        pattern = "[^\"]+"
    end

    -- todo
    for value in string.gmatch(line, pattern) do
        value = value:gsub("\\ ", " ")
        table.insert(myTable, value)
    end

    return myTable
end

function GetRegLinkTable(line)
    local myTable = {}

    -- todo: extend pattern matching to '(HK|hk)'
    for value in string.gmatch(line, "HK[^()\"]+") do
        table.insert(myTable, value)
    end

    return myTable
end

-- @param line string
-- @return table
function GetSystemLinkTable(line)
    local dir = vim.fn.expand('%:p:h')
    local path = ''
    local exist = 0
    local paths = {}

    for _, value in pairs(GetLinkTable(line)) do
        path = value
        exist = vim.fn.filereadable(path)

        if exist == 0 then
            path = dir .. '/' .. value
            exist = vim.fn.filereadable(path)
        end

        if exist == 1 then
            table.insert(paths, path)
        end
    end

    return paths
end

vim.api.nvim_create_user_command(
    'Link',
    function()
        for _, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
            print('Link: ' .. value)
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'LinkClip',
    function()
        local list = ''
        for _, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
            print('LinkClip: ' .. value)
            list = list .. value .. "\n"
        end
        vim.fn.setreg('+', list)
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'LinkShell',
    function()
        local pwshCmd = script_path() .. 'pwsh/Open-Shell.ps1'
        local cmd = ''
        for _, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
            cmd = pwshCmd .. ' -Path "' .. vim.fn.fnamemodify(value, ':h') .. '"'
            print(cmd)
            RunPowerShellNoProfile(cmd)
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'LinkExplore',
    function()
        local cmd = ''
        for _, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
            -- -- (karlr 2025_02_13)
            -- cmd = "explorer " .. vim.fn.fnamemodify(value, ':h'):gsub("/", "\\")

            -- link: Open Explorer and Highlight Specific File with PowerShell
            -- - url: <https://superuser.com/questions/973144/open-explorer-and-highlight-specific-file-with-powershell>
            -- - retrieved: 2025_02_13
            cmd = "explorer /select," .. vim.fn.fnamemodify(value, ':p')
            print(cmd)
            io.popen(cmd)
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'LinkRun',
    function()
        local cmd = ''
        for _, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
            cmd = "start " .. value
            print(cmd)
            io.popen(cmd)
        end
    end,
    { nargs = 0 }
)

-- requires regjump
vim.api.nvim_create_user_command(
    'LinkReg',
    function()
        local pwshCmd = script_path() .. 'pwsh/Open-Registry.ps1'
        local cmd = ''
        local isKey = 0
        for _, value in pairs(GetRegLinkTable(vim.fn.getline('.'))) do
            cmd = pwshCmd .. ' -Path \'' .. value .. '\''
            print(cmd)
            RunElevatedPowerShell(cmd)
        end
    end,
    { nargs = 0 }
)


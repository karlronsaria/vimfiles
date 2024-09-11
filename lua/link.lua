require('define')
require('run')

function GetLinkTable(line)
  local myTable = {}

  print('File type: ' .. vim.bo.filetype)
  print('Line: ' .. line)

  local ext = vim.bo.filetype

  if ext == 'md' then
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

  for key, value in pairs(GetLinkTable(line)) do
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
    for key, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
      print('Link: ' .. value)
    end
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'LinkClip',
  function()
    local list = ''
    for key, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
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
    local pwshCmd = script_path() .. 'nvim/pwsh/Open.ps1'
    local cmd = ''
    for key, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
      cmd = pwshCmd .. ' -Path "' .. vim.fn.fnamemodify(value, ':h') .. '"'
      print(cmd)
      RunPowerShell(cmd)
    end
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'LinkExplore',
  function()
    local cmd = ''
    for key, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
      cmd = "explorer " .. vim.fn.fnamemodify(value, ':h'):gsub("/", "\\")
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
    local pwshCmd = script_path() .. 'nvim/pwsh/Open-Registry.ps1'
    local cmd = ''
    local isKey = 0
    for key, value in pairs(GetRegLinkTable(vim.fn.getline('.'))) do
      cmd = pwshCmd .. ' -Path \'' .. value .. '\''
      print(cmd)
      RunElevatedPowerShell(cmd)
    end
  end,
  { nargs = 0 }
)


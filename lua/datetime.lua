function GetDate()
  return os.date("%Y-%m-%d") -- Uses DateTimeFormat
end

function GetDateTime()
  return os.date("%Y-%m-%d-%H%M%S") -- Uses DateTimeFormat
end

function GetWeekDate()
  return os.date("%a %Y-%m-%d") -- Uses DateTimeFormat
end

vim.api.nvim_create_user_command(
  'PutDate',
  function()
    vim.api.nvim_put({ GetDate() }, 'c', true, true)
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'PutDateTime',
  function()
    vim.api.nvim_put({ GetDateTime() }, 'c', true, true)
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'PutWeekDate',
  function()
    vim.api.nvim_put({ GetWeekDate() }, 'c', true, true)
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'ClipDate',
  function()
    local date = GetDate()
    vim.fn.setreg('+', date)
    print(":ClipDate: Copied '" .. date .. "' to system clipboard")
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'ClipDateTime',
  function()
    local date = GetDateTime()
    vim.fn.setreg('+', date)
    print(":ClipDateTime: Copied '" .. date .. "' to system clipboard")
  end,
  { nargs = 0 }
)

function GetDate()
  return os.date("%Y_%m_%d")
end

function GetDateTime()
  return os.date("%Y_%m_%d_%H%M%S")
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

require('define')

vim.api.nvim_create_user_command(
  'Item',
  function()
    vim.api.nvim_feedkeys(
      [[/\v^(\s*(\*|\-|\d+\.))?\s*\[\zs.+\ze]] .. '\\]' .. special('<CR>'), 'm', true
    )
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'NoNulls',
  function()
    vim.api.nvim_feedkeys(
      [[:%s/\%x00//g]] .. special('<CR>'), 'm', true
    )
  end,
  { nargs = 0 }
)


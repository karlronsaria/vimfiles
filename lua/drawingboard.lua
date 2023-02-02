
function Test()
  -- return vim.fn.getline('.')
  return vim.fn.expand('<cword>')
end

vim.api.nvim_create_user_command(
  'Test',
  function()
    -- vim.api.nvim_put({ Test() }, 'c', true, true)
    print(Test())
  end,
  { nargs = 0 }
)


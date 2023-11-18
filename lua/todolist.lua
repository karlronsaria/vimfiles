require('define')

-- [[/\v^(\s*(\*|\-|\d+\.|[^\w\s]+))? \[\zs[^\]\[]{1,3}\ze]] .. '\\]' .. special('<CR>'),

-- -- OLD (karlr 2023_09_28_210418)
-- -- -----------------------------
-- -- includes non-checkbox items and item tokens that cannot be justified,
-- -- such as strings with brackets in them and anything having a length
-- -- higher than 3
-- -- - ex: ``- [x] see [``todo A``](#todo)``
-- --            ~~~~~~~~~~~~~~~~~~
-- [[/\v^(\s*(\*|\-|\d+\.|[^\w\s]+))? \[\zs.+\ze]] .. '\\]' .. special('<CR>'), 'm', true

-- -- OLD (karlr 2023_09_28_210253)
-- -- -----------------------------
-- -- ignores program annotations (comments)
-- [[/\v^(\s*(\*|\-|\d+\.))? \[\zs.+\ze]] .. '\\]' .. special('<CR>'), 'm', true

local pattern = [[/\v^(\s*(\*|\-|\d+\.|[^\w\s]+))? \[\zs<token>\ze]] .. '\\]'

vim.api.nvim_create_user_command(
  'Item',
  function(opts)
    vim.api.nvim_feedkeys(
      pattern:gsub("<token>", [[[^\]\[]{1,3}]])
        .. [[\s.*]]
        .. (#opts.fargs > 0 and opts.fargs[1] or "")
        .. special('<CR>'),
      'm',
      true
    )
  end,
  { nargs = '?' }
)

vim.api.nvim_create_user_command(
  'Todo',
  function(opts)
    vim.api.nvim_feedkeys(
      pattern:gsub("<token>", [[ ]])
        .. [[\s.*]]
        .. (#opts.fargs > 0 and opts.fargs[1] or "")
        .. special('<CR>'),
      'm',
      true
    )
  end,
  { nargs = '?' }
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



-- link
--   url: https://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
--   retrieved: 2023-01-16

vim.api.nvim_create_user_command(
  'Clippath',
  function()
    vim.api.nvim_feedkeys(
      [[:let @+ = expand("%")]] .. special('<CR>'), 'm', true
    )
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'Clipfullpath',
  function()
    vim.api.nvim_feedkeys(
      [[:let @+ = expand("%:p")]] .. special('<CR>'), 'm', true
    )
  end,
  { nargs = 0 }
)

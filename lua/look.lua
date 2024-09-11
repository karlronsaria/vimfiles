-- # link: transparent background (gui)
-- - url: <https://blog.chaitanyashahare.com/posts/how-to-make-nvim-backround-transparent/>
-- - retrieved: 2024_09_11

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

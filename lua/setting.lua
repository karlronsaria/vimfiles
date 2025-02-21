require('define')

-- -- remap the leader to the spacebar
-- vim.g.mapleader = "\\"

-- Enable syntax highlighting
vim.o.syntax = "on"

-- Change tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Automatically indent when starting new lines in code blocks
vim.o.autoindent = true

-- Show hybrid line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Show column and line number in bottom right
vim.o.ruler = true

vim.o.compatible = false

-- TODO: consider removing
vim.cmd("filetype plugin on")

-- Show whitespace characters
vim.o.listchars = "eol:¬,tab:>·,trail:·,extends:>,precedes:<,nbsp:."
vim.o.list = true

vim.o.statusline = [[%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P]]

vim.cmd([[
    highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
]])

-- link
-- url: <https://vi.stackexchange.com/questions/9831/disable-ctrl-z-in-normal-mode>
-- retrieved: 2022-07-26
nmap("<c-z>", "<nop>")

-- link
-- url: <https://stackoverflow.com/questions/15449591/vim-execute-current-file>
-- retrieved: 2023-10-18
nmap("<f9>", ":!%:p<cr>")

-- (karlr 2025-02-10)
-- change the opacity of popup elements
vim.o.pumblend = 70

-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", blend = 10 }) -- Popup menu
-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#333333", blend = 10 }) -- Selected item


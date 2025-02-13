local lspconfig = require('lspconfig')

-- Setup language servers
lspconfig.clangd.setup{}      -- C++
lspconfig.rust_analyzer.setup{} -- Rust
lspconfig.lua_ls.setup{}       -- Lua

-- Keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })


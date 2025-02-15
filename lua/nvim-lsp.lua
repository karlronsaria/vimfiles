local lspconfig = require('lspconfig')

-- Setup language servers
lspconfig.clangd.setup{}  -- C++
lspconfig.rust_analyzer.setup{}  -- Rust
lspconfig.lua_ls.setup{}  -- Lua
lspconfig.pyright.setup{  -- Python
    settings = {
        pyright = {
            plugins = {
                jedi_completion = { enabled = true },
                rope_completion = { enabled = true },
                pylint = { enabled = true },
                mypy = { enabled = true, live_mode = true },
                pycodestyle = { enabled = true }
            }
        }
    }
}

-- Keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })


local lspconfig = require('lspconfig')
local home_directory = os.getenv('USERPROFILE')

-- Setup language servers
lspconfig.clangd.setup{}  -- C++
lspconfig.rust_analyzer.setup{}  -- Rust
lspconfig.powershell_es.setup{  -- PowerShell
    bundle_path = home_directory .. '/OneDrive/Documents/PowerShell/Modules/PowerShellEditorServices'
}
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
lspconfig.sqlls.setup{}  -- SQL

-- Keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })


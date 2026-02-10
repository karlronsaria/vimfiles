-- local lspconfig = require('lspconfig')
local home_directory = os.getenv('USERPROFILE')

-- Setup language servers
vim.lsp.config('clangd', {})  -- C++
vim.lsp.config('rust_analyzer', {})  -- Rust
vim.lsp.config('powershell_es', {  -- PowerShell
    bundle_path = home_directory .. '/OneDrive/Documents/PowerShell/Modules/PowerShellEditorServices'
})
vim.lsp.config('lua_ls', {})  -- Lua
vim.lsp.config('pyright', {  -- Python
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
})
vim.lsp.config('sqlls', {})  -- SQL
vim.lsp.config('omnisharp', {})  -- C#
vim.lsp.config('csharpier', {})  -- C#
vim.lsp.config('julia-lsp', {})  -- Julia

-- Enable language servers
vim.lsp.enable('clangd')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('powershell_es')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('sqlls')
vim.lsp.enable('omnisharp')
vim.lsp.enable('csharpier')
vim.lsp.enable('julia-lsp')

-- Keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })


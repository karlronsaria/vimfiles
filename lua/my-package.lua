-- # link
-- - url: <https://linovox.com/install-and-use-packer-in-neovim/>
-- - retrieved: 2024_03_29
-- - by: Ashiqur Rahman
-- - since: 2023_08_18

-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- -- Have packer use a popup window
-- packer.init({
--     display = {
--         open_fn = function()
--             return require("packer.util").float({ border = "rounded" })
--         end,
--     },
-- })

local packages = {
    -- packer can manage itself
    'wbthomason/packer.nvim',

    -- tools
    'stsewd/gx-extended.vim',
    'stevedonovan/winapi',
    -- 'sheerun/vim-polyglot',
    -- 'vimwiki/vimwiki',
    'kristijanhusak/vim-simple-notifications',
    'powerline/powerline',

    -- colorscheme
    'gruvbox-community/gruvbox',

    -- tpope 2023_11_17
    'tpope/vim-surround',
    'tpope/vim-repeat',

    -- ast 2023_12_07
    -- 'nvim-treesitter/nvim-treesitter',
    -- 'PowerShell/tree-sitter-PowerShell',
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
    -- 'williamboman/nvim-lsp-installer', -- No longer maintained
    'williamboman/mason.nvim',
}

-- - setup
--
-- ```powershell
-- git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
-- ```

-- Install your plugins here
local result = packer.startup(function(use)
    use ("wbthomason/packer.nvim") -- Have packer manage itself

    use ('williamboman/mason.nvim')

    -- tools
    use ('stsewd/gx-extended.vim')
    use ('stevedonovan/winapi')
    -- use ('sheerun/vim-polyglot')
    -- use ('vimwiki/vimwiki')
    use ('kristijanhusak/vim-simple-notifications')
    use ('powerline/powerline')

    -- colorscheme
    use ('gruvbox-community/gruvbox')
    use ("askfiy/visual_studio_code")
    use ('Mofiqul/vscode.nvim')
    use ('Mofiqul/dracula.nvim')

    use {
        "rockyzhang24/arctic.nvim",
        requires = { "rktjmp/lush.nvim" }
    }

    -- tpope 2023_11_17
    use ('tpope/vim-surround')
    use ('tpope/vim-repeat')

    -- ast 2023_12_07
    use ('nvim-treesitter/nvim-treesitter')
    use ('PowerShell/tree-sitter-PowerShell')
    use ('neovim/nvim-lspconfig')

    -- ast 2024_03_30
    use ('noahfrederick/vim-composer')

    -- nvim-cmp 2025_02_10
    use ('hrsh7th/cmp-nvim-lsp')
    use ('hrsh7th/cmp-buffer')
    use ('hrsh7th/cmp-path')
    use ('hrsh7th/cmp-cmdline')

    use {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip"
        }
    }

    -- snippet engine 2025_02_10
    use ('hrsh7th/cmp-vsnip')
    use ('hrsh7th/vim-vsnip')

    -- for _, package in pairs(packages) do
    --     use(package)
    -- end

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[colorscheme arctic]])
vim.cmd([[colorscheme dracula]])

return result


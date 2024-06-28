-- # link
-- - url: <https://linovox.com/install-and-use-packer-in-neovim/>
-- - retrieved: 2024_03_29
-- - by: Ashiqur Rahman
-- - since: 2023_08_18

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
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
return packer.startup(function(use)
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

    -- tpope 2023_11_17
    use ('tpope/vim-surround')
    use ('tpope/vim-repeat')

    -- ast 2023_12_07
    use ('nvim-treesitter/nvim-treesitter')
    use ('PowerShell/tree-sitter-PowerShell')
    use ('neovim/nvim-lspconfig')

    -- ast 2024_03_30
    use ('noahfrederick/vim-composer')

    -- for _, package in pairs(packages) do
    --     use(package)
    -- end

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

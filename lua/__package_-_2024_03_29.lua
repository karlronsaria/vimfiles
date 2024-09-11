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
    'nvim-treesitter/nvim-treesitter',
    'PowerShell/tree-sitter-PowerShell',
    'neovim/nvim-lspconfig',
    -- 'williamboman/nvim-lsp-installer', -- No longer maintained
    'williamboman/mason.nvim',
}

-- - link
--   - url: <https://linovox.com/install-and-use-packer-in-neovim/>
--   - retrieved: 2024_03_29
--
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- - setup
--
-- ```powershell
-- git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
-- ```
--
return require'packer'.startup(function(use)
    for _, package in pairs(packages) do
        use(package)
    end
end)

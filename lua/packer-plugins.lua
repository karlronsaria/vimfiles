-- setup
--   powershell:
--     git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
--
return require('packer').startup(function(use)
    -- packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'stsewd/gx-extended.vim'

    use 'stevedonovan/winapi'
    use 'sheerun/vim-polyglot'
    use 'vimwiki/vimwiki'
    use 'kristijanhusak/vim-simple-notifications'
    use 'powerline/powerline'

    -- colorscheme
    use 'gruvbox-community/gruvbox'
end)

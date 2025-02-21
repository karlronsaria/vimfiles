" Enable syntax highlighting
syntax on

" Change tabs
set expandtab
set tabstop=4
set shiftwidth=4

" Automatically indent when starting new lines in code blocks
set autoindent

" Add line numbers
set number relativenumber

" Show column and line number in bottom right
set ruler

set nocompatible
filetype plugin on

" Show whitespace characters
set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<,nbsp:.
set list

:set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE

" colorscheme dracula

" link: https://vi.stackexchange.com/questions/9831/disable-ctrl-z-in-normal-mode
" retrieved: 2022-07-26
:noremap <c-z> <nop>


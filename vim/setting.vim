" (karlr 2024-09-25): added because of a problem
" with the Vim extension in VsCode
:set path+=**

" (karlr 2024-09-25): change fileformat to dos
" - link
"   - url
"     - <https://stackoverflow.com/questions/1505978/how-do-i-hide-the-eol-doc-chars-m-in-vim>
"     - <https://stackoverflow.com/questions/16656811/vim-on-windows-started-showing-m-characters>
"   - retrieved: 2023-01-25
:set fileformat=dos
:set number relativenumber

" " (karlr 2023-02-05)
" :ed ++ff=dos %

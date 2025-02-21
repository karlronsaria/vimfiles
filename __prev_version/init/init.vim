" link: https://github.com/dhruvasagar/dotfiles/blob/master/vim/vimrc
" link: https://stackoverflow.com/questions/46964475/how-can-i-source-files-relative-to-file
" link: https://stackoverflow.com/users/145525/dhruva-sagar
" retrieved: 2022-03-22
"
:function SourceFiles(config_list)
:  let g:vim_home = get(g:, 'vim_home', expand('~/.vim/'))
:
:  " " NeoBundle {{{1
:  " exec 'source' g:vim_home.'/packs.vim'
:
:  " Load all vim configs {{{1
:  for myfiles in a:config_list
:    for f in glob(g:vim_home . myfiles, 1, 1)
:      exec 'source' f
:    endfor
:  endfor
:
:  " Set at the end to work around 'exrc'
:  set secure
:endfunction

let config_list = [
  \ '*.vim',
  \]

call SourceFiles(config_list)


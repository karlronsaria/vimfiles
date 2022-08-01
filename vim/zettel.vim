
" ********************
" * --- Packages --- *
" ********************

call plug#begin()
    Plug 'ctrlpvim/ctrlp.vim'
call plug#end()


" ***********************
" * --- Self-quizes --- *
" ***********************

" tags: #markdown #selfquiz
" link: https://www.edwinwenink.xyz/posts/50-quiz_yourself_in_vim/
" retrieved: 2022_03_18
"
" Ex:
"   (1 of 8): **Q**: Why is the triangle mesh so useful for real-time rasterization?
nnoremap <leader>nq :vimgrep /\*\*Q\*\*/ %<CR>

" link: https://www.edwinwenink.xyz/posts/50-quiz_yourself_in_vim/
" retrieved: 2022_03_18
"
" Paste from quickfix list (handy to collect the questions somewhere)
nnoremap <leader>pq :execute PasteQuickfix()<CR>

:function! PasteQuickfix()
:   for q in getqflist()
:       put =q.text
:   endfor
:endfunction

" todo
"   install
"     choco: ripgrep
"       link: https://github.com/BurntSushi/ripgrep
:fun! s:workaroundIssue2190()
:    " see https://github.com/vim/vim/issues/2190
:    if &buftype == 'terminal' && !exists('b:workaround_issue_2190')
:        autocmd BufWriteCmd <buffer> echo 'workaround 2190'
:        let b:workaround_issue_2190 = 1
:    endif
:endfun
aug workaroundIssue2190
    autocmd! BufWinEnter * call s:workaroundIssue2190()
aug END

" Make Ctrlp use ripgrep
if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_user_caching = 0
endif

" Make :grep use ripgrep
if executable('rg')
    set grepprg=rg\ --color=never\ --vimgrep
endif


" *****************
" * --- Ctags --- *
" *****************

" todo
"   install
"     choco: ctags / universal-ctags
"   vim
"     In .ctags using Exuberant Ctags
"
"       --langdef=markdowntags
"       --langmap=markdowntags:.md
"       --regex-markdowntags=/(^|[[:space:]])@(\w\S*)/\2/t,tag,tags/
"
"     In .ctags using Universal Ctags
"       In project directory
"         vim ./.ctags.d/md.ctags
"
"           --langdef=markdowntags
"           --languages=markdowntags
"           --langmap=markdowntags:.md
"           --kinddef-markdowntags=t,tag,tags
"           --mline-regex-markdowntags=/(^|[[:space:]])@(\w\S*)/\2/t/{mgroup=1}

" howto
"   setup
"     Generate ctags
"       nnoremap <leader>tt :!ctags -R . <CR>
"     Generate ctags silently
"       nnoremap <leader>tt :silent !ctags -R . <CR>:redraw!<CR>

" Generate ctags for current working directory
nnoremap <leader>tt :silent !ctags -R . <CR>:redraw!<CR>

" Binding for searching tags ("search tag")
nnoremap <leader>st :CtrlPTag<CR>

" This step is probably not necessary for you,
" but I'll add it here for completeness
set tags+=./tags;,tags

" Ignore case in searches
set ignorecase

" howto: get word under cursor
" link: https://stackoverflow.com/questions/1115447/how-can-i-get-the-word-under-the-cursor-and-the-text-of-the-current-line-in-vim
" link: https://stackoverflow.com/users/5445/christian-c-salvad%c3%b3
" retrieved: 2022_04_08

" karlr (2022_04_08)
" Search tag under cursor
nnoremap <leader>si :call feedkeys(":CtrlPTag\r".expand("<cword>"))<CR>

" tip: check the 'tags' variable
" vim: :set tags?

" tip: search for 'workflow' (ignorecase)
" vim:
"   :tselect workflow
"   :ts workflow
"   :ts work<TAB>
"   :ts Work<TAB>

" tip: search tag under cursor
" vim: <C-]>

" tip: search matching tag definitions under cursor
" vim: g]

" tip: navigate the currently traversed tag stack
" vim: <C-t>

" tip: Ctrl-P help
" vim: :help ctrlp-mapping


" *****************
" * --- Notes --- *
" *****************

" Change directory to directory of current file
nnoremap <leader>cd :cd %:h<CR>

" $NOTE_DIR is a bash variable that I set in my ~/.bashrc:
"
" todo
"   bash
"     export NOTE_DIR=/home/edwin/Documents/Notes
"
" Go to index of notes and set working directory to my notes
nnoremap <leader>ni :e $NOTE_DIR/index.md<CR>:cd $NOTE_DIR<CR>

" 'Notes Grep' with ripgrep (see grepprg)
" -i case insensitive
" -g glob pattern
" ! in `grep!` to prevent immediately opening first search result
command! -nargs=1 Ngrep :silent grep! "<args>" -i -g '*.md' $NOTE_DIR | execute ':redraw!'
nnoremap <leader>nn :Ngrep

" Open quickfix list in a right vertical split (good for Ngrep results)
command! Vlist botright vertical copen | vertical resize 50
nnoremap <leader>v :Vlist<CR>

" Make CtrlP and grep use ripgrep
if executable('rg')
    set grepprg=rg\ --color=never\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_user_caching = 0
endif

" What to ignore while searching files, speeds up CtrlP
set wildignore+=*/.git/*,*/tmp/*,*.swp


" ******************
" * --- Zettel --- *
" ******************

let g:zettel = $NOTE_DIR."/zettel/"

:function! GetNewZettelName(name = '', ext = '.md', delim = '-')
:   let datetime = g:zettel.strftime("%Y%m%d%H%M")
:
:   if a:name == ''
:      return datetime.a:ext
:   endif
:
:   return datetime.a:delim.a:name.a:ext
:endfunction

" Quickly create a new entry into the "Zettelkasten" 
command! -nargs=? NewZettel :execute ":e" GetNewZettelName("<args>")
nnoremap <leader>nz :NewZettel 

" CtrlP function for inserting a markdown link with Ctrl-X
:function! CtrlPOpenFunc(action, line)
:   if a:action =~ '^h$'
:      " Get the filename
:      let filename = fnameescape(fnamemodify(a:line, ':t'))
:      let filename_wo_timestamp = fnameescape(fnamemodify(a:line, ':t:s/\d\+-//'))
:
:      " Close CtrlP
:      call ctrlp#exit()
:      call ctrlp#mrufiles#add(filename)
:
:      " Insert the markdown link to the file in the current buffer
:      let mdlink = "[".filename_wo_timestamp."](".filename.")"
:      put=mdlink
:   else
:      " Use CtrlP's default file opening function
:      call call('ctrlp#acceptfile', [a:action, a:line])
:   endif
:endfunction

let g:ctrlp_open_func = {
    \ 'files': 'CtrlPOpenFunc',
    \ 'mru files': 'CtrlPOpenFunc'
\ }


" shortcuts
" ---------
" Quickfix list
" :cn[ext]          go to next
" :cp[revious]      go to prev
" :cw               open list
" :cop[n]
" :ccl[ose]         close list
" :c2               go to item 2 in list
" :cr               open first item in window
" :cl               open last item in window
" :ca               open all in different windows
" :sp myfile.txt    open myfile.txt in hsplit
" :vsp myfile.txt   open myfile.txt in vsplit
" :cc 2             jump to item 2 and echo it
" :colder           navigate older lists
" :cnewer           navigate newer list
"
" Buffers
" :ls               list buffers
" :buffers
"
" Location list
" :ll               open location lists
"
" <CR>              open in prev window
" <C-w>v            open in horizontal split
" <C-w>s            open in vertical split
"
" gf                go to file or url under cursor in new window
" gF                go to file or url under cursor in same window
"
" cs[cope]
"
" {                 previous paragraph
" }                 next paragraph
"
" <C-b>             previous page
" <C-f>             next page
"
" <C-B>             previous full screen
" <C-F>             next full screen
"
" ciw               change whole word under cursor
" dis               delete whole sentence under cursor
" yip               yank whole paragraph under cursor
" ci"               change everything in quotes under cursor
"

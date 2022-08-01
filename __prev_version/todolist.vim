:command Item :call feedkeys("/\\v^\\s*-?\\s*\\[\\zs.+\\ze\\]\<CR>")
:command Nonulls :call feedkeys(":%s/\\%x00//g\<CR>")


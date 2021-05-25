nnoremap <leader>nb :silent grep! -P '%:t'  /home/mike/Notes/daily/*<cr>
nnoremap <leader>nn :silent Dispatch pandoc --defaults notepdf %:p -o /home/mike/Notes/preview.pdf<cr>

" finding notes
nnoremap <leader>nf :lua require('mike.telescope').notes_by_tag()<CR>
nnoremap <leader>nd :lua require('mike.telescope').notes_dailies()<CR>


augroup MIKE_PANDOC
  au!
  autocmd VimLeave *.tex :!texclear %:p
  autocmd BufEnter,BufLeave pandoc :set wrap
  " autocmd BufEnter *.markdown :MaximizerToggle
  " autocmd FileType pandoc nnoremap <buffer> <leader>nb :silent grep! -P '%:t'  /home/mike/Notes/daily/*<cr>
  " Doc stuff
  autocmd InsertLeave /home/mike/Notes/docs/**/chapters/*.md :w|Dispatch compile_doc
  autocmd BufWritePost /home/mike/Notes/docs/**/chapters/*.md :Dispatch compile_doc
  autocmd BufEnter /home/mike/Notes/docs/**/chapters/*.md inoremap <buffer> <C-s> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.$CURRENTDOC.'/figures/"'<CR><CR>:w<CR>
  autocmd BufEnter /home/mike/Notes/docs/**/chapters/*.md nnoremap <buffer> <C-s> : silent exec '!inkscape-figures edit "'.$CURRENTDOC.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
  " Notes stuff
  autocmd FileType pandoc nnoremap <buffer> <expr> gf bufwinid(fnamemodify(expand("<cfile>"), ":t")) != -1 ? ':let curf=expand("<cfile>")<cr>:call setpos(".", [0,0,0,0])<cr>:call win_gotoid(bufwinid(fnamemodify(curf, ":t")))<cr>' : fnamemodify(bufname(), ":h") == "daily" ? ':vs <c-r>=fnamemodify("daily/".expand("<cfile>"), ":.")<cr><cr>' : ':vs <c-r>="".fnamemodify(bufname(), ":h")."/".fnamemodify(expand("<cfile>"), ":.")<cr><cr>'
  autocmd InsertLeave /home/mike/Notes/notes/**/*.md :w|Dispatch compile_note %:p
  autocmd BufWritePost /home/mike/Notes/notes/**/*.md :Dispatch compile_note %:p
  autocmd InsertLeave /home/mike/Notes/notes/*.md :w|Dispatch! compile_note %:p
  autocmd BufWritePost /home/mike/Notes/notes/*.md :Dispatch! compile_note %:p
  autocmd BufEnter /home/mike/Notes/notes/**/*.md inoremap <buffer> <C-s> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.'/home/mike/Notes/notes/daily'.'/figures/"'<CR><CR>:w<CR>
  autocmd BufEnter /home/mike/Notes/notes/**/*.md nnoremap <buffer> <C-s> : silent exec '!inkscape-figures edit "'.'/home/mike/Notes/notes/daily'.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
  autocmd BufEnter /home/mike/Notes/notes/*.md inoremap <buffer> <C-s> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.'/home/mike/Notes/notes'.'/figures/"'<CR><CR>:w<CR>
  autocmd BufEnter /home/mike/Notes/notes/*.md nnoremap <buffer> <C-s> : silent exec '!inkscape-figures edit "'.'/home/mike/Notes/notes'.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
augroup END
let g:tex_flavor = "latex"
let g:pandoc#biblio#bibs = ["/home/mike/Notes/bibliography.bib"]
let g:pandoc#syntax#conceal#urls = 1
let g:mkdp_filetypes = ['markdown', 'pandoc']


function! Synctex()
    execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
    redraw!
endfunction
map <C-enter> :call Synctex()<cr>


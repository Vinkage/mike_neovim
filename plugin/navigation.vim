let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if g:the_primeagen_qf_l == 1 || g:the_primeagen_qf_g == 1
        if a:global
            let g:the_primeagen_qf_g = 0
            let g:the_primeagen_qf_l = 0
            cclose
        else
            let g:the_primeagen_qf_l = 0
            cclose
        endif
    else
        if a:global
            let g:the_primeagen_qf_g = 1
            copen
        else
            let g:the_primeagen_qf_l = 1
            lopen
        endif
    endif
endfun

nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <C-l> :call ToggleQFList(0)<CR>

fun! NextScope()
    if g:the_primeagen_qf_l == 1
        return 0
    else
        return 1
    endif
endfun

nnoremap <expr> <c-k> NextScope() ? ':cnext<cr>':':lnext<cr>'
nnoremap <expr> <c-j> NextScope() ? ':cprev<cr>':':lprev<cr>'
" nnoremap <C-k> :cnext<CR>
" nnoremap <C-j> :cprev<CR>



nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

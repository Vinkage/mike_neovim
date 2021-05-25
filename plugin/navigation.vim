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

" nnoremap <c-g> <c-u>
" nnoremap <C-k> :cnext<CR>
" nnoremap <C-j> :cprev<CR>

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" let g:maximizer_restore_on_winleave = 1
" let g:maximizer_restore_on_winleave = 1

nnoremap <tab> za
nnoremap <S-tab> zA

let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'

let g:ulti_expand_or_jump_res = 0
function! Ulti_available()
    let can_jump=UltiSnips#CanJumpForwards()
    let can_expand=UltiSnips#CanExpandSnippet()
    if (can_jump != 0) || (can_expand != 0)
        return 1
    else
        return 0
    endif
endfunction

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : Ulti_available() ? '<tab>' : ''
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : Ulti_available() ? '<tab>' : ''



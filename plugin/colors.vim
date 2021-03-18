fun! ColorMyPencils()
    let g:mike_color="gruvbox"
    colorscheme gruvbox
    set background=dark

    let g:gruvbox_contrast_dark = 'hard'
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection='0'

    highlight ColorColumn ctermbg=0 guibg=grey
    highlight Normal guibg=none
    " highlight LineNr guifg=#ff8659
    " highlight LineNr guifg=#aed75f
    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
endfun

fun! AyuPencil()
    let g:mike_color="ayu"
    let ayucolor="light"
    colorscheme ayu
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    highlight Normal guibg=none
endfun

fun! ColorSwitch()
    if g:mike_color == 'gruvbox'
        call AyuPencil()
    elseif g:mike_color == 'ayu'
        call ColorMyPencils()
    endif
endfun

call ColorMyPencils()

" Vim with me
nnoremap <leader>vwm :call ColorSwitch()<CR>

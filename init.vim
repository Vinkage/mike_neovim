set exrc " Wont open project .nvimrc without this here

call plug#begin('/home/mike/.vim/plugged')
" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'tjdevries/lsp_extensions.nvim'
" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" Vim
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'
Plug 'gruvbox-community/gruvbox'
" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Colors
Plug 'sainnhe/gruvbox-material'
" Cheat Sheet
" Plug 'dbeniamine/cheat.sh-vim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'
" R and python
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'psf/black', { 'branch': 'stable' }
Plug 'jpalardy/vim-slime'
" Sql
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'SirVer/ultisnips'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mfussenegger/nvim-jdtls'
Plug 'mfussenegger/nvim-dap'
call plug#end()

let g:python3_host_prog = $XDG_CONFIG_HOME . '/nvim/venv/bin/python3'

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

nnoremap <leader>cP :lua require("contextprint").add_statement()<CR>
nnoremap <leader>cp :lua require("contextprint").add_statement(true)<CR>

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Sex!<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

inoremap <C-c> <esc>

fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup MIKE_GLOBAL
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

aug MIKE_R
    autocmd!
    autocmd FileType r inoremap <buffer> > <Esc>:normal! a %>%<CR>a
    autocmd FileType r nnoremap <buffer> K <Esc>:Rh <C-r>=expand("<cword>")<cr><cr>
    autocmd FileType r nnoremap <buffer> s :set opfunc=SendMotionToR<CR>g@
    autocmd FileType r nnoremap <buffer> <leader>vh :Rhelp <c-r>=expand("<cword>")<cr><cr>
aug END

aug MIKE_PYTHON
    autocmd!
    autocmd FileType python nnoremap <leader>f :Black<CR>
    autocmd FileType python nmap <buffer> <silent> s <Plug>SlimeMotionSend
    autocmd FileType python nmap <buffer> <silent> <C-Enter> <Plug>:JupyterSendCell<CR>
    autocmd FileType python nnoremap <cr> :JupyterSendCell<cr>
    " Send whole file to jupyter console.
    autocmd FileType python onoremap f :<c-u>normal! mzggVG<cr>`z
aug END

augroup MIKE_LATEX
  au!
  autocmd VimLeave *.tex :!texclear %:p
  autocmd FileType tex nnoremap <cr> :Dispatch compiler %:p<cr>
augroup END

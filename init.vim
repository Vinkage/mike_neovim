set exrc " Wont open project .nvimrc without this here

call plug#begin('/Users/mike/.vim/plugged')

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" THANKS BFREDL
" Plug '/home/mpaulson/personal/contextprint.nvim'
Plug 'bryall/contextprint.nvim'

Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'vuciv/vim-bujo'
Plug 'tpope/vim-dispatch'
Plug 'gruvbox-community/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-projectionist'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

"  I AM SO SORRY FOR DOING COLOR SCHEMES IN MY VIMRC, BUT I HAVE
"  TOOOOOOOOOOOOO

Plug 'sainnhe/gruvbox-material'

" Fire Nvim
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(69) } }

" Cheat Sheet
" Plug 'dbeniamine/cheat.sh-vim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

" R plugin
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

Plug 'kassio/neoterm'

Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
let g:python3_host_prog = $XDG_CONFIG_HOME . '/nvim/venv/bin/python3'


let g:vimspector_install_gadgets = [ 'debugpy' ]

let g:neoterm_eof = "\<CR>"
let g:neoterm_bracketed_paste = 1


let g:vim_be_good_log_file = 1
let g:vim_apm_log = 1

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

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

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

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF

" let g:completion_chain_complete_list = {
"     \ 'r': [
"     \    {'mode': 'omni'},
"     \],
"     \ 'rmd': [
"     \    {'mode': 'omni'},
"     \],
"     \ 'default': [
"     \    {'complete_items': ['lsp', 'snippet']},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'}
"     \]
" \}

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    " autocmd VimEnter * :VimApm
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

nmap s <Plug>(neoterm-repl-send)
nmap <C-Enter> <Plug>RDSendLine
nmap <leader>s :RSend rmarkdown::render('<C-r>=expand("%:p")<cr>', 'html_document')<cr>

aug R_MIKE
    autocmd!
    autocmd FileType r inoremap <buffer> > <Esc>:normal! a %>%<CR>a
    autocmd FileType rmd inoremap <buffer> > <Esc>:normal! a %>%<CR>a
    autocmd FileType r nnoremap <buffer> K <Esc>:Rh <C-r>=expand("<cword>")<cr><cr>
    autocmd FileType rmd nnoremap <buffer> K <Esc>:Rh <C-r>=expand("<cword>")<cr><cr>
aug END

let g:neoterm_default_mod='vertical'

aug PY_MIKE
    autocmd!
    autocmd FileType python nnoremap <leader>f :Black<CR>
aug END

tnoremap <C-c><C-c> <C-\><C-n>
nnoremap <leader>q :copen<cr>
nnoremap <leader>Q :cclose<cr>

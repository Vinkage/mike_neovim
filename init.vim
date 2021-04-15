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
" Plug 'vuciv/vim-bujo'
Plug 'tpope/vim-dispatch'
Plug 'gruvbox-community/gruvbox'
" Plug 'tpope/vim-projectionist'
" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Colors
Plug 'sainnhe/gruvbox-material'
Plug 'ayu-theme/ayu-vim'
" Fire Nvim
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(69) } }
" Cheat Sheet
" Plug 'dbeniamine/cheat.sh-vim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'
" R
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
" Python
Plug 'psf/black', { 'branch': 'stable' }
Plug 'jupyter-vim/jupyter-vim'
" Tex
Plug 'donRaphaco/neotex', { 'for': 'tex' }
" Sql
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

let g:db_ui_use_nerd_fonts = 1
let ayucolor = "light"
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          -- Or you can define your own textobjects like this
          ["iF"] = {
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function",
          },
        },
      },
    },
  }
EOF

let g:python3_host_prog = $XDG_CONFIG_HOME . '/nvim/venv/bin/python3'

let g:vimspector_install_gadgets = [ 'debugpy' ]

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

augroup ALWAYS_MIKE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

aug R_MIKE
    autocmd!
    autocmd FileType r inoremap <buffer> > <Esc>:normal! a %>%<CR>a
    autocmd FileType rmd inoremap <buffer> > <Esc>:normal! a %>%<CR>a
    autocmd FileType r nnoremap <buffer> K <Esc>:Rh <C-r>=expand("<cword>")<cr><cr>
    autocmd FileType rmd nnoremap <buffer> K <Esc>:Rh <C-r>=expand("<cword>")<cr><cr>
    autocmd FileType r nnoremap <buffer> s :set opfunc=SendMotionToR<CR>g@
    autocmd FileType r inoremap <buffer> <C-s> <Esc>:set opfunc=SendMotionToR<CR>g@
    autocmd FileType rmd nnoremap <buffer> s :set opfunc=SendMotionToR<CR>g@
aug END

aug PY_MIKE
    autocmd!
    autocmd FileType python nnoremap <leader>f :Black<CR>
    autocmd FileType python nmap <buffer> <silent> s <Plug>JupyterRunTextObj
    autocmd FileType python nmap <buffer> <silent> <C-Enter> <Plug>:JupyterSendCell<CR>
    autocmd FileType python nnoremap <cr> :JupyterSendCell<cr>
    " Send whole file to jupyter console.
    autocmd FileType python onoremap f :<c-u>normal! mzggVG<cr>`z
aug END

tnoremap <C-c><C-c> <C-\><C-n>

let g:tex_flavor = "latex"

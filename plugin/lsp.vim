set completeopt=menuone,noinsert,noselect,preview

lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    vim_dadbod_completion = true;
  };
}
EOF

nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>vll :lua vim.lsp.diagnostic.set_loclist()<CR>

fun! LspLocationList()
    lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
endfun

aug MIKE_LSP
    au!
    au BufWrite,BufEnter * :call LspLocationList()
aug END


let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.texlab.setup{}
" lua require'lspconfig'.r_language_server.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.sourcekit.setup{ on_attach=require'completion'.on_attach }
" lua require'nvim_lsp'.sumneko_lua.setup{ on_attach=require'completion'.on_attach }


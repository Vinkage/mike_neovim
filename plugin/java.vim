" if has('nvim-0.5')
"   augroup lsp
"     au!
"     au FileType java lua require('mike.java').setup()
"     au FileType java nnoremap m<cr> :Dispatch javacompile %<cr>
"     au FileType java nnoremap <leader>vca <Cmd>lua require('jdtls').code_action()<CR>
"     au FileType java vnoremap <leader>vca <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
"     au FileType java nnoremap <leader>vrf <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>
"     au FileType java nnoremap <leader>voi <Cmd>lua require'jdtls'.organize_imports()<CR>
"     au FileType java nnoremap <leader>vev <Cmd>lua require('jdtls').extract_variable()<CR>
"     au FileType java vnoremap <leader>vev <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
"     au FileType java vnoremap <leader>vem <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
"     au FileType java nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
"     au FileType java nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
"     au FileType java nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
"     au FileType java nnoremap <silent> <leader>dj :lua require'dap'.step_over()<CR>
"     au FileType java nnoremap <silent> <leader>dl :lua require'dap'.step_into()<CR>
"     au FileType java nnoremap <silent> <leader>dk :lua require'dap'.step_out()<CR>
"     au FileType java nnoremap <silent> <leader>dbp :lua require'dap'.toggle_breakpoint()<CR>
"     au FileType java nnoremap <silent> <leader>dcbp :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
"     au FileType java nnoremap <silent> <leader>dlbp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
"     au FileType java nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
"     au FileType java nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
"     au VimLeave *.java :!javaclear
"   augroup end
" endif
" " lua require('mike.java').setup()
" " aug MIKE_JAVA
" "     au!
" " aug end
"

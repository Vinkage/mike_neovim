lua << EOF
local actions = require('telescope.actions')
-- Built-in actions
local transform_mod = require('telescope.actions.mt').transform_mod

-- helps my custom action
local entry_to_qf = function(entry)
  print(type(entry.value))
  if type(entry.value) == "table" then
      entry.value = entry.value.text
  end
  return {
    bufnr = entry.bufnr,
    filename = entry.filename,
    lnum = entry.lnum,
    col = entry.col,
    text = entry.value,
  }
end

local custom_actions = transform_mod({
  send_to_qflist = function(prompt_bufnr)
    print("This function ran after another action. Prompt_bufnr: " .. prompt_bufnr)
    local picker = actions.get_current_picker(prompt_bufnr)
    local manager = picker.manager

    local qf_entries = {}
    for entry in manager:iter() do
      table.insert(qf_entries, entry_to_qf(entry))
    end

    actions.close(prompt_bufnr)

    vim.fn.setqflist(qf_entries, 'r')
  end,
})


require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = actions.goto_file_selection_split,
        ["<C-q>"] = custom_actions.send_to_qflist,
      },
    }
  }
}
EOF


nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <C-q> :lua require('telescope.builtin').quickfix()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>


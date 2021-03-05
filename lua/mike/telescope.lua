local actions = require('telescope.actions')
-- Built-in actions
local transform_mod = require('telescope.actions.mt').transform_mod

-- helps my custom action
local entry_to_qf = function(entry)
  -- print(type(entry.value))
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
    -- print("This function ran after another action. Prompt_bufnr: " .. prompt_bufnr)
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

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = custom_actions.send_to_qflist,
      },
    }
  },
  extensions = {
      fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true
      }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = "$HOME/dotfiles/mike_neovim/",
    })
end

M.git_branches = function() 
    require("telescope.builtin").git_branches({
        attach_mappings = function(prompt_bufnr, map) 
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

return M

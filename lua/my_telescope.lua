-- Built-in actions
local transform_mod = require('telescope.actions.mt').transform_mod

-- or create your custom action
local my_cool_custom_action = transform_mod({
  x = function()
   print("This function ran after another action. Prompt_bufnr: " .. prompt_bufnr)
   -- Enter your function logic here. You can take inspiration from lua/telescope/actions.lua
  end,
})

local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    mappings = {
      i = {
        -- To disable a keymap, put [map] = false
        -- So, to not map "<C-x>", just put
        -- Otherwise, just set the mapping to the function that you want it to be.
        -- Add up multiple actions
        -- You can perform as many actions in a row as you like
        ["<C-q>"] = my_cool_custom_action,
      },
      -- n = {
      --   ["<esc>"] = actions.close,
      --   ["<C-i>"] = my_cool_custom_action,
      -- },
    },
  }
}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local sorters = require "telescope.sorters"
local action_state = require "telescope.actions.state"
local dropdown = require "telescope.themes".get_dropdown()

function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
  actions.close(prompt_bufnr)
end

function next_color(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

function prev_color(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

local opts = {
  -- finder = finders.new_table { "radium", "material", "catppuccin" },
  finder = finders.new_table { 
    'aquarium', 'ayu-dark', 'blossom', 'catppuccin', 'catppuccin_latte', 'chadracula', 'chadtain', 'chocolate', 'doomchad', 'everforest', 'everforest_light', 'gatekeeper', 'gruvbox', 'gruvbox_light', 'gruvchad', 'jellybeans', 'kanagawa', 'material', 'monekai', 'mountain', 'nightfox', 'nightlamp', 'nightowl', 'nord', 'one_light', 'onedark', 'onenord', 'onenord_light', 'palenight', 'pastelDark', 'radium', 'rosepine', 'rxyhn', 'sweetpastel', 'tokyodark', 'tokyonight', 'tomorrow_night', 'vscode_dark', 'wombat'
  },
  sorter = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(prompt_bufnr, map)
    map("i", "<CR>", enter)
    map("i", "<Tab>", next_color)
    map("i", "<S-Tab>", prev_color)
    return true
  end,
}

local colors = pickers.new(opts, {
  prompt_title = 'Choose the Color'
})

colors:find()

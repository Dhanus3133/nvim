return({
  "andweeb/presence.nvim",
  -- enabled = false,
  config = function()
    require("presence"):setup({
      -- log_level = "debug",
      enable_line_number = false,
      main_image = "file",
      buttons = false,
      neovim_image_text = "Neovim",
      debounce_timeout = 10,

      workspace_text = "Fixing some shit",
      editing_text = "Editing stuff",
    })
  end,
})

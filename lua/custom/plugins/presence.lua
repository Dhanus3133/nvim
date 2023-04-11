return {
  "andweeb/presence.nvim",
  config = function()
    require("presence"):setup({
      -- log_level = "debug",
      buttons = false,
      enable_line_number = false,
      main_image = "file",
      buttons = true,
      neovim_image_text = "Neovim",
      debounce_timeout = 10,
    })
  end,
}

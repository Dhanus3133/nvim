return {
  "segeljakt/vim-silicon",
  config = function()
    vim.g.silicon = {
      font = "JetBrainsMono Nerd Font",
      output = "~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png",
    }
  end,
}

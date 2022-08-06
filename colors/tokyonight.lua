vim.g.colors_name = "tokyonight"
vim.api.nvim_command[[
    autocmd ColorScheme * highlight CursorLineNr guifg=#fff
]]

require("pconfig.colorscheme").setup {
  base00 = "#1A1B26",
  base01 = "#3b4261",
  base02 = "#3b4261",
  base03 = "#545c7e",
  base04 = "#565c64",
  base05 = "#a9b1d6",
  base06 = "#bbc5f0",
  base07 = "#c0caf5",
  base08 = "#f7768e",
  base09 = "#ff9e64",
  base0A = "#ffd089",
  base0B = "#9ece6a",
  base0C = "#2ac3de",
  base0D = "#7aa2f7",
  base0E = "#bb9af7",
  base0F = "#c0caf5",
}

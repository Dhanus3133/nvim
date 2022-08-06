vim.g.colors_name = "sweetpastel"
vim.api.nvim_command[[
    autocmd ColorScheme * highlight CursorLineNr guifg=#fff
]]

require("pconfig.colorscheme").setup {
  base00 = "#1B1F23",
  base01 = "#25292d",
  base02 = "#2f3337",
  base03 = "#393d41",
  base04 = "#43474b",
  base05 = "#FDE5E6",
  base06 = "#DEE2E6",
  base07 = "#F8F9FA",
  base08 = "#e5a3a1",
  base09 = "#F1C192",
  base0A = "#ECE3B1",
  base0B = "#B4E3AD",
  base0C = "#F8B3CC",
  base0D = "#A3CBE7",
  base0E = "#CEACE8",
  base0F = "#e5a3a1",
}

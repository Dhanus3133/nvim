vim.g.colors_name = "one_light"
vim.api.nvim_command[[
    autocmd ColorScheme * highlight CursorLineNr guifg=#fff
]]

require("pconfig.colorscheme").setup {
  base00 = "#fafafa",
  base01 = "#f4f4f4",
  base02 = "#e5e5e6",
  base03 = "#dfdfe0",
  base04 = "#d7d7d8",
  base05 = "#383a42",
  base06 = "#202227",
  base07 = "#090a0b",
  base08 = "#d84a3d",
  base09 = "#a626a4",
  base0A = "#c18401",
  base0B = "#50a14f",
  base0C = "#0070a8",
  base0D = "#4078f2",
  base0E = "#a626a4",
  base0F = "#986801",
}

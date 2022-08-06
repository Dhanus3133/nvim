vim.g.colors_name = "tokyodark"
vim.api.nvim_command[[
    autocmd ColorScheme * highlight CursorLineNr guifg=#fff
]]

require("pconfig.colorscheme").setup {
  base00 = "#11121d",
  base01 = "#1b1c27",
  base02 = "#21222d",
  base03 = "#282934",
  base04 = "#30313c",
  base05 = "#abb2bf",
  base06 = "#b2b9c6",
  base07 = "#A0A8CD",
  base08 = "#ee6d85",
  base09 = "#7199ee",
  base0A = "#7199ee",
  base0B = "#dfae67",
  base0C = "#a485dd",
  base0D = "#95c561",
  base0E = "#a485dd",
  base0F = "#f3627a",
}

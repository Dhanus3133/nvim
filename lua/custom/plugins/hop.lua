return {
  "phaazon/hop.nvim",
  keys = {
    { "ff", "<cmd>HopWord<CR>", desc = "Hop Word" },
    { "fc", "<cmd>HopChar1CurrentLine<CR>", desc = "Hop Char current line" },
    { "fl", "<cmd>HopLineStart<CR>", desc = "Hop Line start" },
  },
  config = function()
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
  end,
}

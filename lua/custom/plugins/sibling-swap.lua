return {
  "Wansmer/sibling-swap.nvim",
  requires = { "nvim-treesitter" },
  keys = {
    { "<A-l>", ":lua require('sibling-swap').swap_with_right()<CR>", desc = "Swap with right" },
    { "<A-h>", ":lua require('sibling-swap').swap_with_left()<CR>", desc = "Swap with left" },
    {
      "<space>.",
      ":lua require('sibling-swap').swap_with_right_with_opp()<CR>",
      desc = "Swap with right with opposite",
    },
    {
      "<space>,",
      ":lua require('sibling-swap').swap_with_left_with_opp()<CR>",
      desc = "Swap with left with opposite",
    },
  },
  config = function()
    require("sibling-swap").setup({
      use_default_keymaps = false,
    })
  end,
}

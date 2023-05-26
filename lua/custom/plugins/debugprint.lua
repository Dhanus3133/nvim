return {
  "andrewferrier/debugprint.nvim",
  keys = {
    {
      "<leader>Dp",
      function()
        return require("debugprint").debugprint()
      end,
      desc = "Print current line below for debugging",
      expr = true,
    },
    {
      "<leader>DP",
      function()
        return require("debugprint").debugprint({ above = true })
      end,
      desc = "Print current line above for debugging",
      expr = true,
    },
    {
      "<leader>Dv",
      mode = { "n", "x" },
      function()
        return require("debugprint").debugprint({ variable = true })
      end,
      desc = "Print variable below for debugging",
      expr = true,
    },
    {
      "<leader>DV",
      mode = { "n", "x" },
      function()
        return require("debugprint").debugprint({ variable = true, above = true })
      end,
      desc = "Print variable above for debugging",
      expr = true,
    },
    {
      "<leader>DD",
      "<cmd>DeleteDebugPrints<cr>",
      desc = "Delete all debug prints",
    },
  },
  opts = {
    create_keymaps = false,
    move_to_debugline = false,
  },
}

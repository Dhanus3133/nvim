return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble", mode = "n" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics", mode = "n" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics", mode = "n" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Loclist", mode = "n" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix", mode = "n" },
    { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References", mode = "n" },
  },
  -- opts = {},
}

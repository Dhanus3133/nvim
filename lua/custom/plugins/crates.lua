return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("crates").setup()
  end,
  keys = {
    { "<leader>ct", "<cmd>lua require('crates').toggle()<CR>", desc = "Toggle crates" },
    { "<leader>cr", "<cmd>lua require('crates').reload()<CR>", desc = "Reload crates" },
    { "<leader>cv", "<cmd>lua require('crates').show_versions_popup()<CR>", desc = "Show versions" },
    { "<leader>cf", "<cmd>lua require('crates').show_features_popup()<CR>", desc = "Show features" },
    { "<leader>cd", "<cmd>lua require('crates').show_dependencies_popup()<CR>", desc = "Show dependencies" },
    { "<leader>cu", "<cmd>lua require('crates').update_crate()<CR>", desc = "Update crate" },
    { "<leader>ca", "<cmd>lua require('crates').update_all_crates()<CR>", desc = "Update all crates" },
    { "<leader>cU", "<cmd>lua require('crates').upgrade_crate()<CR>", desc = "Upgrade crate" },
    { "<leader>cA", "<cmd>lua require('crates').upgrade_all_crates()<CR>", desc = "Upgrade all crates" },
    { "<leader>cH", "<cmd>lua require('crates').open_homepage()<CR>", desc = "Open crate homepage" },
    { "<leader>cR", "<cmd>lua require('crates').open_repository()<CR>", desc = "Open crate repository" },
    { "<leader>cD", "<cmd>lua require('crates').open_documentation()<CR>", desc = "Open crate documentation" },
    { "<leader>cC", "<cmd>lua require('crates').open_crates_io()<CR>", desc = "Open in crates.io" },
    {
      "<leader>ce",
      "<cmd>lua require('crates').expand_plain_crate_to_inline_table()<CR>",
      desc = "Expand crate to inline table",
    },
    { "<leader>cE", "<cmd>lua require('crates').extract_crate_into_table()<CR>", desc = "Extract Crate into table" },
    { "<leader>cu", "<cmd>lua require('crates').update_crate()<CR>", mode = "v", desc = "Update crate" },
    { "<leader>cU", "<cmd>lua require('crates').upgrade_crates()<CR>", mode = "v", desc = "Upgrade crates" },
  },
}

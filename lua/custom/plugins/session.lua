return {
  "rmagatti/auto-session",
  dependencies = { "rmagatti/session-lens" },
  lazy = false,
  opts = {
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_save_on_quit = true,
    auto_session_enable_last_session = false,
  },
  keys = {
    { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Session Save" },
    { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "Session Restore" },
  },
}

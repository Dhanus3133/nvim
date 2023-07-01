return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  keys = {
    { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
    { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
    { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
    { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
    { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
    { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Find oldfiles" },
    { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },
    { "<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "Git commits" },
    { "<leader>gt", "<cmd> Telescope git_status <CR>", desc = "Git status" },
    { "<leader>pt", "<cmd> Telescope terms <CR>", desc = "Pick hidden term" },
    { "<leader>th", "<cmd> Telescope themes <CR>", desc = "PicK themes" },
    { "<leader>ma", "<cmd> Telescope marks <CR>", desc = "Telescope bookmarks" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("media_files")
    telescope.load_extension("file_browser")
    telescope.load_extension("project")
    telescope.setup({
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          find_cmd = "rg", -- find command (defaults to `fd`)
        },
      },
    })
  end,
}

return {
  "krivahtoo/silicon.nvim",
  build = "./install.sh build",
  keys = {
    { "<leader>ss", ":Silicon! ", mode = "v", desc = "Screenshot a code snippet" },
    { "<leader>sc", ":Silicon<cr>", mode = "v", desc = "Screenshot a code snippet into the clipboard" },
  },
  config = function()
    require("silicon").setup({
      require("silicon").setup({
        font = "FantasqueSansMono Nerd Font=26",
        background = "#87f",
        theme = "Monokai Extended",
        line_number = true,
        pad_vert = 80,
        pad_horiz = 50,
        output = {
          path = os.getenv("HOME") .. "/Screenshots",
        },
        watermark = {
          text = " @Dhanus3133",
        },
        window_title = function()
          return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
        end,
      }),
    })
  end,
}

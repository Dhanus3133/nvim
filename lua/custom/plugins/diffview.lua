return {
  "sindrets/diffview.nvim",
  keys = {
    {
      "<leader><leader>v",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
      desc = "DiffView",
    },
  },
}

return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {
      "<leader>gs",
      '<cmd>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
      desc = "Switch git worktree",
    },
    {
      "<leader>gc",
      '<cmd>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>',
      desc = "Create git worktree",
    },
  },
  config = function()
    require("git-worktree").setup({})
    require("telescope").load_extension("git_worktree")
    local Worktree = require("git-worktree")
    local AutoSession = require("auto-session")
    local NvimTree = require("nvim-tree.api")

    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Switch then
        -- Restore session
        AutoSession.RestoreSession(metadata.path)
        -- Refresh path in nvim-tree
        NvimTree.tree.toggle({ path = metadata.path })
        NvimTree.tree.toggle({ path = metadata.path })
      end
    end)
  end,
}

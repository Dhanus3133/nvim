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
        vim.notify("Switched from " .. metadata.prev_path .. " => " .. metadata.path)
        for _, e in ipairs(require("bufferline").get_elements().elements) do
          vim.schedule(function()
            if e.id == vim.api.nvim_get_current_buf() then
              return
            else
              vim.cmd("bd " .. e.id)
            end
          end)
        end
        vim.cmd("e")
      end

      if op == Worktree.Operations.Create then
        vim.notify("Created " .. metadata.branch .. " in " .. metadata.path)
      end

      if op == Worktree.Operations.Delete then
        vim.cmd("SessionDelete")
        vim.notify("Deleted " .. metadata.path)
      end
    end)
  end,
}

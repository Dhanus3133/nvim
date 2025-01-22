require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "html",
    "css",
    "typescript",
    "javascript",
    "rust",
    "json",
    "yaml",
    "toml",
    "bash",
    "python",
    "cpp",
    "c",
    "cmake",
    "dockerfile",
    "go",
    "graphql",
    "haskell",
    "jsonc",
    "json5",
    "tsx",
    "vue",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
  autopairs = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  matchup = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Around a function" },
        ["if"] = { query = "@function.inner", desc = "Inner part of a function" },
        ["ac"] = { query = "@class.outer", desc = "Around a class" },
        ["ic"] = { query = "@class.inner", desc = "Inner part of a class" },
        ["ai"] = { query = "@conditional.outer", desc = "Around an if statement" },
        ["ii"] = { query = "@conditional.inner", desc = "Inner part of an if statement" },
        ["al"] = { query = "@loop.outer", desc = "Around a loop" },
        ["il"] = { query = "@loop.inner", desc = "Inner part of a loop" },
        ["ap"] = { query = "@parameter.outer", desc = "Around parameter" },
        ["ip"] = { query = "@parameter.inner", desc = "Inside a parameter" },
      },
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@parameter.inner"] = "v", -- charwise
        ["@function.outer"] = "v", -- charwise
        ["@conditional.outer"] = "V", -- linewise
        ["@loop.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
      include_surrounding_whitespace = false,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Previous function" },
        ["[c"] = { query = "@class.outer", desc = "Previous class" },
        ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
      },
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Next function" },
        ["]c"] = { query = "@class.outer", desc = "Next class" },
        ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})

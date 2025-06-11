return {
  { lazy = true, "nvim-lua/plenary.nvim" },

  {
    "nvchad/ui",
    config = function()
      require("nvchad")
    end,
  },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "NvChad/volt",
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "andymass/vim-matchup",
    },
    config = function()
      require("plugins.configs.treesitter")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",

      --list of default snippets
      "rafamadriz/friendly-snippets",

      -- snippets engine
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },

      -- autopairs , autocompletes ()[] etc
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup()

          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          local cmp = require("cmp")
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
    },
    -- made opts a function cuz cmp config calls cmp module
    -- and we lazyloaded cmp so we dont want that file to be read on startup!
    opts = function()
      return require("plugins.configs.cmp")
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.lspconfig")
    end,
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
    opts = require("plugins.configs.conform"),
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { char = "│", highlight = "Comment" },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "debugloop/telescope-undo.nvim",
    },
    cmd = "Telescope",
    opts = require("plugins.configs.telescope"),
    config = function()
      local _, telescope = pcall(require, "telescope")
      pcall(telescope.load_extension, "file_browser")
      pcall(telescope.load_extension, "undo")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function()
      require("plugins.configs.gitsigns")
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = true,
    ft = { "rust" },
    opts = require("plugins.configs.rustaceanvim"),
    config = function(_, opts)
      -- Set Options
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      local crates = require("crates")
      crates.setup()
    end,
  },

  {
    "Pocco81/auto-save.nvim",
    opts = require("plugins.configs.autosave"),
  },

  {
    "laytan/cloak.nvim",
    opts = require("plugins.configs.cloak"),
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = require("plugins.configs.copilot"),
  },

  {
    "sindrets/diffview.nvim",
    lazy = true,
    opts = require("plugins.configs.diffview"),
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "pwntester/octo.nvim",
    lazy = true,
    cmd = { "Octo" },
    config = function()
      require("plugins.configs.octo")
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = true,
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight", "TmuxNavigatePrevious" },
  },

  { "wakatime/vim-wakatime" },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  {
    "szw/vim-maximizer",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      require("plugins.configs.dap")
    end,
    opts = {},
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  -- {
  --   "cordx56/rustowl",
  --   version = "*", -- Latest stable version
  --   build = "cd rustowl && cargo install --path . --locked",
  --   lazy = false, -- This plugin is already lazy
  --   opts = {
  --     client = {
  --       on_attach = function(_, buffer)
  --         vim.keymap.set("n", "<leader>o", function()
  --           require("rustowl").toggle(buffer)
  --         end, { buffer = buffer, desc = "Toggle RustOwl" })
  --       end,
  --     },
  --   },
  -- },
}

local M = {}

M.base46 = {
  theme = "radium",
}

M.ui = {
  statusline = { theme = "default" },

  cmp = {
    icons_left = true,
    format_colors = {
      tailwind = true,
    },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    [[      __  __                _             ]],
    [[     / | / /__  ____ _   __(_)_______     ]],
    [[    /  |/ / _ \/ __ \ | / / / __ `__ \    ]],
    [[   / /|  /  __/ /_/ / |/ / / / / / / /    ]],
    [[  / / | /    /\____/| / / / / / / / /     ]],
    [[ /_/  |/\___/ 𝕯𝖍𝖆𝖓𝖚𝖘|__/_/_/ /_/ /_/      ]],
    [[                                          ]],
    [[       Dhanus3133 |  dhanus-sl          ]],
    [[                                          ]],
  },
  buttons = {
    { txt = "  Find File", keys = "f", cmd = "Telescope find_files" },
    { txt = "  New file", keys = "e", cmd = ":ene <BAR> startinsert" },
    { txt = "  Recent Files", keys = "o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "w", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "t", cmd = ":lua require('nvchad.themes').open({ border=true })" },
    { txt = "  Mappings", keys = "m", cmd = "NvCheatsheet" },
    { txt = "  Configuration", keys = "c", cmd = ":e $MYVIMRC" },
    { txt = "  Quit Neovim", keys = "q", cmd = ":qa" },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. " 󱓞"
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}

M.mason = {
  pkgs = {
    "stylua",
    "black",
    "prettier",
    "gofmt",
    "clang-format",
    "rustfmt",
    "shfmt",
    "markdownlint",
    "sqlfluff",
    "json_tool",
    "stylelint",
    "djlint",
  },
}

return M

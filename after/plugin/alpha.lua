local present, alpha = pcall(require, "alpha")
if not present then
  return
end

local dashboard = require("alpha.themes.dashboard")
local if_nil = vim.F.if_nil

-- Header
local header = {
  [[      __  __                _             ]],
  [[     / | / /__  ____ _   __(_)_______     ]],
  [[    /  |/ / _ \/ __ \ | / / / __ `__ \    ]],
  [[   / /|  /  __/ /_/ / |/ / / / / / / /    ]],
  [[  / / | /    /\____/| / / / / / / / /     ]],
  [[ /_/  |/\___/ 𝕯𝖍𝖆𝖓𝖚𝖘|__/_/_/ /_/ /_/      ]],
}

dashboard.section.header.type = "text"
dashboard.section.header.val = header
dashboard.section.header.opts = {
  position = "center",
  hl = "AlphaHeader",
}

local thingy = io.popen('echo "$(LANG=en_us_88591; date +%a) $(date +%d) $(LANG=en_us_88591; date +%b)" | tr -d "\n"')
if thingy == nil then
  return
end
local date = thingy:read("*a")
thingy:close()

local datetime = os.date(" %H:%M")

local hi_top_section = {
  type = "text",
  val = "┌──────────────   Today "
    .. date
    .. " ─────────────┐",
  opts = {
    position = "center",
    hl = "AlphaHeaderInfo",
  },
}

local hi_middle_section = {
  type = "text",
  val = "│                                                │",
  opts = {
    position = "center",
    hl = "AlphaHeaderInfo",
  },
}

local hi_bottom_section = {
  type = "text",
  val = "└───══───══───══───  "
    .. datetime
    .. "  ───══───══───══────┘",
  opts = {
    position = "center",
    hl = "AlphaHeaderInfo",
  },
}

-- Copied from Alpha.nvim source code

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "AlphaPrimary",
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    -- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
    local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

dashboard.section.buttons.val = {
  button("f", "󰈞  Find file", ":Telescope find_files <CR>", {}),
  button("e", "  New file", ":ene <BAR> startinsert <CR>", {}),
  button("p", "  Find project", ":Telescope project <CR>", {}),
  button("r", "  Recently used files", ":Telescope oldfiles <CR>", {}),
  button("t", "  Find text", ":Telescope live_grep <CR>", {}),
  button("c", "  Configuration", ":e $MYVIMRC <CR>", {}),
  button("q", "  Quit Neovim", ":qa<CR>", {}),
}

-- Footer
local function footer()
  local plugins = require("lazy").stats().count
  local v = vim.version()
  return string.format(" v%d.%d.%d    %d Plugins   Dhanus3133", v.major, v.minor, v.patch, plugins)
end

dashboard.section.footer.val = {
  footer(),
}
dashboard.section.footer.opts = {
  position = "center",
  hl = "Alphafooter",
}

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}

-- Setup
local opts = {
  layout = {
    { type = "padding", val = 3 },
    section.header,
    { type = "padding", val = 1 },
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    { type = "padding", val = 1 },
    section.buttons,
    { type = "padding", val = 1 },
    section.footer,
  },
  opts = {
    margin = 5,
  },
}

alpha.setup(opts)

-- Hide tabline and statusline on startup screen
vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  command = "set showtabline=0 laststatus=0 noruler",
})

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  callback = function()
    vim.api.nvim_create_autocmd("BufUnload", {
      group = "alpha_tabline",
      buffer = 0,
      command = "set showtabline=2 ruler laststatus=3",
    })
  end,
})

local options = {
  number = true,
  ruler = true,
  relativenumber = true,
  splitright = true,
  splitbelow = true,
  smarttab = true,
  expandtab = true,
  smartindent = true,
  autoindent = true,
  tabstop = 4,
  shiftwidth = 4,
  autoread = true,
  title = true,
  termguicolors = true,
  hlsearch = true,
  hidden = true,
  encoding = "utf-8",
  fileencoding = "utf-8",
  showmode = false,
  clipboard = "unnamedplus",
  swapfile = false,
  laststatus = 3,
  undofile = true,
  undodir = os.getenv("HOME") .. "/.cache/nvim/undo",
  undolevels = 1000,
  undoreload = 10000,
  scrolloff = 8,
  sidescrolloff = 8,
  ignorecase = true,
  cursorline = true,
  linebreak = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

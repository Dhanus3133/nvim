require("options")
require("mappings")

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")

require("lazy").setup(plugins)

pcall(require, "nvchad")

if vim.fn.isdirectory(vim.g.base46_cache) ~= 1 then
  local status, base46 = pcall(require, "base46")
  if status then
    base46.load_all_highlights()
  end
end

if vim.fn.isdirectory(vim.g.base46_cache) == 1 then
  for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
  end
end

local status, db_config = pcall(require, "private.db_config")
if status then
  vim.g.dbs = db_config.dbs
end

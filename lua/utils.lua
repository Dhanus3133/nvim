local M = {}

function M.get_git_directory()
  local Job = require("plenary.job")
  local s, ret = Job:new({
    command = "git",
    args = { "rev-parse", "--show-superproject-working-tree", "--show-toplevel" },
  }):sync()
  if ret == 0 then
    return s[1]
  else
    return vim.loop.cwd()
  end
end

function M.strip_trailing_slash(dir)
  if string.sub(dir, -1, -1) == "/" then
    dir = string.sub(dir, 1, -2)
  end
  return dir
end

return M

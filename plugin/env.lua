local api, fn, fs = vim.api, vim.fn, vim.fs
local fmt = string.format

api.nvim_create_user_command("DotEnv", function()
  local files = fs.find(".env", {
    upward = true,
    stop = fn.fnamemodify(fn.getcwd(), ":p:h:h"),
    path = fn.expand("%:p:h"),
  })
  if vim.tbl_isempty(files) then
    return
  end
  vim.cmd("e " .. files[1])
end, {})

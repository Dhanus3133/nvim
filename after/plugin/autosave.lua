require("auto-save").setup({
  enabled = true,
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")
    if fn.bufname(buf) == "lua/plugins.lua" then
      return false
    end
    if fn.bufname(buf):find("octo://", 1, true) then
      return false
    end
    if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), { "gitcommit" }) then
      return true -- met condition(s), can save
    end
    return false -- can't save
  end,
  -- execution_message = 'AutoSave: saved at ' .. vim.fn.strftime('%H:%M:%S'),
  events = { "InsertLeave", "TextChanged" },
  conditions = { exists = true, modifiable = true },
  write_all_buffers = false,
  on_off_commands = true,
  clean_command_line_interval = 0,
  debounce_delay = 135,
})

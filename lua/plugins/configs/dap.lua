local dap, dapui = require("dap"), require("dapui")
require("dapui").setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })

require("nvim-dap-virtual-text").setup({
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
  --- A callback that determines how a variable is displayed or whether it should be omitted
  --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
  --- @param buf number
  --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
  --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
  --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
  --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
  display_callback = function(variable, buf, stackframe, node, options)
    -- by default, strip out new line characters
    if options.virt_text_pos == "inline" then
      return " = " .. variable.value:gsub("%s+", " ")
    else
      return variable.name .. " = " .. variable.value:gsub("%s+", " ")
    end
  end,
  -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
  virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

  -- experimental features:
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

local has_mason, mason_registry = pcall(require, "mason-registry")
if has_mason then
  local debugpy = mason_registry.get_package("debugpy")
  local path = vim.fs.joinpath(vim.fn.expand("$MASON"), "packages", debugpy.name, "")
  require("dap-python").setup(path .. "venv/bin/python")
end

-- require("nvim-dap-virtual-text").setup({
--   enabled = true, -- enable this plugin (the default)
--   enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  -- highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  -- highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
--   show_stop_reason = true, -- show stop reason when stopped for exceptions
--   commented = false, -- prefix virtual text with comment string
--   only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
--   all_references = false, -- show virtual text on all all references of the variable (not only definitions)
--   filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
--   -- experimental features:
--   virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
--   all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
--   virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
--   virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
--   -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
-- })

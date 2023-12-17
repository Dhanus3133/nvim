local icons = { dap = require("others.icons").get("dap") }

local dap = require("dap")
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close()
end

local function compile_and_get_executable_path()
  local filetype = vim.bo.filetype
  local filepath = "/tmp/" -- vim.fn.expand("%:p:h") .. "/"
  local executable

  if filetype == "c" then
    local input = vim.fn.expand("%:t")
    executable = filepath .. "a.out"
    vim.fn.system("rm -f " .. executable)
    vim.fn.system("gcc -g " .. input .. " -o " .. executable)
  elseif filetype == "cpp" then
    local input = vim.fn.expand("%:t")
    executable = filepath .. "a.out"
    vim.fn.system("rm -f " .. executable)
    vim.fn.system("g++ -g " .. input .. " -o " .. executable)
  elseif filetype == "rust" then -- TODO: this is not working for now
    vim.fn.system("cargo build --bin " .. vim.fn.expand("%:t:r"))
    executable = filepath .. "target/debug/" .. vim.fn.expand("%:t:r")
  elseif filetype == "java" then
    vim.fn.system("javac -g" .. vim.fn.expand("%:t"))
    local classname = vim.fn.expand("%:t:r")
    executable = filepath .. classname .. ".class"
  else
    print("Unsupported filetype")
    return
  end
  return executable
end
-- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ABE9B3" })

vim.fn.sign_define("DapBreakpoint", { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode",
  name = "lldb",
}
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = compile_and_get_executable_path,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.go = function(callback)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      vim.notify(
        string.format('"dlv" exited with code: %d, please check your configs for correctness.', code),
        vim.log.levels.WARN,
        { title = "[go] DAP Warning!" }
      )
    end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(function()
    callback({ type = "server", host = "127.0.0.1", port = port })
  end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  { type = "go", name = "Debug", request = "launch", program = "${file}" },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  }, -- works with go.mod packages and sub packages
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",
    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python"
      end
    end,
  },
}

vim.keymap.set("n", "<Leader>Dc", dap.run_to_cursor, { desc = "Run to Cursor" })
vim.keymap.set("n", "<Leader>DE", function()
  dap.eval(vim.fn.input("[Expression] > "))
end, { desc = "Evaluate Input" })
vim.keymap.set("n", "<Leader>DB", function()
  dap.set_breakpoint(vim.fn.input("[Condition] > "))
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<Leader>DU", dapui.toggle, { desc = "Toggle UI" })
vim.keymap.set("n", "<Leader>Dd", dap.disconnect, { desc = "Disconnect" })
vim.keymap.set("n", "<Leader>De", dapui.eval, { desc = "Evaluate" })
vim.keymap.set("n", "<Leader>Dg", dap.session, { desc = "Get Session" })
-- Value for the expression under the cursor
vim.keymap.set("n", "<Leader>Dh", require("dap.ui.widgets").hover, { desc = "Hover Variables" })
-- current scopes in a floating window
vim.keymap.set("n", "<Leader>DS", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })
vim.keymap.set("n", "<Leader>Dq", dap.close, { desc = "Quit" })
vim.keymap.set("n", "<Leader>Dr", dap.repl.toggle, { desc = "Toggle Repl" })

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start" })
vim.keymap.set("n", "<F8>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<Leader>Dx", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<Leader>Di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<Leader>Du", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<Leader>Do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<Leader>Db", dap.step_back, { desc = "Step Back" })

vim.keymap.set("v", "<Leader>De", dapui.eval, { desc = "Evaluate" })

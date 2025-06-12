local nt = require("neotest")
local cov = require("coverage")

local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)

cov.setup({
  signs = {
    covered = { priority = 100 },
    uncovered = { priority = 100 },
  },
  auto_reload = true,
})
nt.setup({
  adapters = {
    require("neotest-rust"),
    require("neotest-python"),
    require("neotest-vitest"),
  },
})

local run_all = function()
  nt.run.run(vim.fn.getcwd())
end

local run_all_in_file = function()
  nt.run.run(vim.fn.expand("%"))
end

local debug_nearest_test = function()
  nt.run.run({ strategy = "dap" })
end

local watch_current_file = function()
  require("neotest").watch.toggle(vim.fn.expand("%"))
end

local map = vim.keymap.set

map("n", "<leader>tn", nt.run.run, { desc = "Run nearest test" })
map("n", "<leader>tl", nt.run.run_last, { desc = "Run last test" })
map("n", "<leader>to", nt.output.open, { desc = "Show output from closest test" })
map("n", "<leader>ts", nt.summary.toggle, { desc = "Toggle or focus the test summary" })
map("n", "<leader>ta", run_all, { desc = "Run all tests" })
map("n", "<leader>tf", run_all_in_file, { desc = "Run all tests in the current file" })
map("n", "<leader>td", debug_nearest_test, { desc = "Run nearest test with debugger" })
map("n", "<leader>tw", watch_current_file, { desc = "Toggle watching the current file" })

local run_coverage = function()
  local Job = require("plenary.job")

  local ftype = vim.bo.filetype
  vim.notify("🚀 Running coverage command...", vim.log.levels.INFO)
  if ftype == "rust" then
    local output_path = "/tmp/lcov.info"

    Job:new({
      command = "cargo",
      args = {
        "llvm-cov",
        "nextest",
        "--lcov",
        "--output-path",
        output_path,
        "--no-cfg-coverage",
      },
      on_exit = function(job, return_val)
        vim.schedule(function()
          if return_val == 0 then
            cov.load_lcov(output_path)
            cov.show()
            vim.notify("✅ Coverage Loaded...", vim.log.levels.INFO)
          else
            vim.notify("❌ Coverage command failed: \n" .. vim.inspect(job:stderr_result()), vim.log.levels.ERROR)
          end
        end)
      end,
    }):start()
  else
    cov.load(true)
  end
end

map("n", "<leader>tcc", run_coverage, { desc = "Run Coverage" })
map("n", "<leader>tct", cov.toggle, { desc = "Toggle Coverage Signs" })
map("n", "<leader>tcC", cov.clear, { desc = "Clear Coverage" })
map("n", "<leader>tcs", cov.summary, { desc = "Summary Coverage" })

local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent

-- nvimtree
map("n", "t", "<cmd> NvimTreeToggle <CR>")

-- telescope
map("n", "<leader>tt", "<cmd> Telescope <CR>", { desc = "Telescope" })
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })
map("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "Telescope bookmarks" })
map("n", "<leader>fe", "<cmd> Telescope file_browser <CR>", { desc = "File Browser" })
map("n", "<leader>tu", "<cmd> Telescope undo <CR>", { desc = "Undo Browser" })

-- bufferline, cycle buffers
map("n", "<S-l>", "<cmd>lua require('nvchad.tabufline').next() <CR>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>lua require('nvchad.tabufline').prev() <CR>", { desc = "Previous Buffer" })
map("n", "]b", "<cmd>lua require('nvchad.tabufline').move_buf(1) <CR>", { desc = "Move Next Buffer" })
map("n", "[b", "<cmd>lua require('nvchad.tabufline').move_buf(-1) <CR>", { desc = "Move Previous Buffer" })
map("n", "cc", "<cmd>lua require('nvchad.tabufline').close_buffer() <CR>", { desc = "Close Buffer" })
map("n", "<leader>cab", "<cmd>lua require('nvchad.tabufline').closeAllBufs(true) <CR>", { desc = "Close All Buffers" })
map(
  "n",
  "<leader>crb",
  "<cmd>lua require('nvchad.tabufline').closeAllBufs(false) <CR>",
  { desc = "Close All Other Buffers" }
)
for i = 1, 9 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    if vim.t.bufs[i] and vim.api.nvim_buf_is_valid(vim.t.bufs[i]) then
      vim.api.nvim_set_current_buf(vim.t.bufs[i])
    end
  end)
end

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

-- format
map("n", "<leader>k", function()
  require("conform").format()
end, { desc = "Code Format" })

map("n", "<C-t>", function()
  require("nvchad.themes").open({ border = true })
end)

-- terminal
vim.keymap.set({ "n", "t" }, ";", function()
  require("nvchad.term").toggle({
    pos = "float",
    relative = "editor",
    id = "floatTerm",
    float_opts = {
      row = 0.13,
      col = 0.14,
      width = 0.7,
      height = 0.7,
    },
  })
end)

map({ "n", "t" }, "<leader>gg", function()
  require("nvchad.term").toggle({
    pos = "float",
    cmd = "lazygit",
    id = "LazyGitTerm",
    float_opts = {
      width = 1,
      height = 1,
    },
  })
end, { desc = "LazyGit" })

map({ "n", "t" }, "<leader>gd", function()
  require("nvchad.term").toggle({
    pos = "float",
    cmd = "lazydocker",
    id = "LazyDockerTerm",
    float_opts = {
      width = 1,
      height = 1,
    },
  })
end, { desc = "LazyDocker" })

-- window
map("n", "<leader>wv", "<C-w>v", { desc = "Window Split vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Window split horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Window splits equal size" })
map("n", "<leader>wx", "<cmd>close<CR>", { desc = "Window close current split" })

map("i", "jk", "<ESC>")

-- diffview.nvim
map("n", "<leader><leader>v", function()
  local diffview = require("diffview.lib")
  if next(diffview.views) == nil then
    vim.cmd("DiffviewOpen")
  else
    vim.cmd("DiffviewClose")
  end
end, { desc = "Toggle DiffView" })

-- Tmux Navigator
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate to the left pane" })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate to the bottom pane" })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate to the top pane" })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate to the right pane" })
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate to the previous pane" })

-- vim-maximizer
map({ "n", "v" }, "F", "<cmd>MaximizerToggle<cr>", { desc = "Full Screen" })

-- LSP Inlay hints
map("n", "<C-i>", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

-- DAP
map("n", "<Leader>Dc", function()
  require("dap").run_to_cursor()
end, { desc = "Run to Cursor" })

map("n", "<Leader>DE", function()
  require("dap").eval(vim.fn.input("[Expression] > "))
end, { desc = "Evaluate Input" })

map("n", "<Leader>DB", function()
  require("dap").set_breakpoint(vim.fn.input("[Condition] > "))
end, { desc = "Conditional Breakpoint" })

map("n", "<Leader>DC", function()
  require("dap").clear_breakpoints()
end, { desc = "clear breakpoints" })

map("n", "<Leader>DU", function()
  require("dapui").toggle()
end, { desc = "Toggle UI" })

map("n", "<Leader>Dd", function()
  require("dap").disconnect()
end, { desc = "Disconnect" })

map("n", "<Leader>De", function()
  require("dapui").eval()
end, { desc = "Evaluate" })

map("n", "<Leader>Dg", function()
  require("dap").session()
end, { desc = "Get Session" })

map("n", "<Leader>Dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Hover Variables" })

map("n", "<Leader>DS", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })

map("n", "<Leader>Dq", function()
  require("dap").close()
end, { desc = "Quit" })

map("n", "<Leader>Dr", function()
  require("dap").repl.toggle()
end, { desc = "Toggle Repl" })

map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Start/Continue" })

map("n", "<F8>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<Leader>Dx", function()
  require("dap").terminate()
end, { desc = "Terminate" })

map("n", "<Leader>Di", function()
  require("dap").step_into()
end, { desc = "Step Into" })

map("n", "<Leader>Du", function()
  require("dap").step_out()
end, { desc = "Step Out" })

map("n", "<Leader>Do", function()
  require("dap").step_over()
end, { desc = "Step Over" })

map("n", "<Leader>Db", function()
  require("dap").step_back()
end, { desc = "Step Back" })

map("v", "<Leader>De", function()
  require("dapui").eval()
end, { desc = "Evaluate" })

-- crates.nvim
map("n", "<leader>ct", function()
  require("crates").toggle()
end, { desc = "Toggle Crates" })
map("n", "<leader>cr", function()
  require("crates").reload()
end, { desc = "Reload Crates" })

map("n", "<leader>cv", function()
  require("crates").show_versions_popup()
end, { desc = "Show Versions Popup" })
map("n", "<leader>cf", function()
  require("crates").show_features_popup()
end, { desc = "Show Features Popup" })
map("n", "<leader>cd", function()
  require("crates").show_dependencies_popup()
end, { desc = "Show Dependencies Popup" })

map("n", "<leader>cu", function()
  require("crates").update_crate()
end, { desc = "Update Crate" })
map("v", "<leader>cu", function()
  require("crates").update_crates()
end, { desc = "Update Crates" })
map("n", "<leader>ca", function()
  require("crates").update_all_crates()
end, { desc = "Update All Crates" })
map("n", "<leader>cU", function()
  require("crates").upgrade_crate()
end, { desc = "Upgrade Crate" })
map("v", "<leader>cU", function()
  require("crates").upgrade_crates()
end, { desc = "Upgrade Crates" })
map("n", "<leader>cA", function()
  require("crates").upgrade_all_crates()
end, { desc = "Upgrade All Crates" })

map("n", "<leader>cx", function()
  require("crates").expand_plain_crate_to_inline_table()
end, { desc = "Expand Plain Crate to Inline Table" })
map("n", "<leader>cX", function()
  require("crates").extract_crate_into_table()
end, { desc = "Extract Crate into Table" })

map("n", "<leader>cH", function()
  require("crates").open_homepage()
end, { desc = "Open Homepage" })
map("n", "<leader>cR", function()
  require("crates").open_repository()
end, { desc = "Open Repository" })
map("n", "<leader>cD", function()
  require("crates").open_documentation()
end, { desc = "Open Documentation" })
map("n", "<leader>cC", function()
  require("crates").open_crates_io()
end, { desc = "Open Crates.io" })
map("n", "<leader>cL", function()
  require("crates").open_lib_rs()
end, { desc = "Open lib.rs" })

-- rest.nvim
map("n", "<leader>ro", function()
  vim.cmd("Rest open")
end, { desc = "Open Rest Result Pane" })

map("n", "<leader>rr", function()
  vim.cmd("Rest run")
end, { desc = "Run HTTP Request under Cursor" })

map("n", "<leader>rl", function()
  vim.cmd("Rest last")
end, { desc = "Run Last HTTP Request" })

map("n", "<leader>rg", function()
  vim.cmd("Rest logs")
end, { desc = "Edit Rest Logs File" })

map("n", "<leader>rc", function()
  vim.cmd("Rest cookies")
end, { desc = "Edit Cookies File" })

map("n", "<leader>rs", function()
  vim.cmd("Rest env show")
end, { desc = "Show Environment Variables" })

map("n", "<leader>re", function()
  vim.cmd("Telescope rest select_env")
end, { desc = "Select & Register Environment File" })

-- gitlinker.nvim
map("n", "<leader>gb", function()
  require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
end, { desc = "GitLinker: Open file in browser" })

map("v", "<leader>gb", function()
  require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
end, { desc = "GitLinker: Open selection in browser" })

map("n", "<leader>gY", function()
  require("gitlinker").get_repo_url()
end, { desc = "GitLinker: Copy repo URL" })

map("n", "<leader>gB", function()
  require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
end, { desc = "GitLinker: Open repo in browser" })

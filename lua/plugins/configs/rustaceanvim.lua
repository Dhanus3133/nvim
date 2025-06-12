local function setup_rust_lsp()
  local has_mason, mason_registry = pcall(require, "mason-registry")
  local adapter
  local rust_analyzer_binary

  if has_mason then
    -- DAP binaries
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = vim.fs.joinpath(vim.fn.expand("$MASON"), "packages", codelldb.name, "extension/")
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = ""

    -- Find Rust Analyzer binary path in mason registry
    local ra_package = mason_registry.get_package("rust-analyzer")
    local install_dir = vim.fs.joinpath(vim.fn.expand("$MASON"), "packages", ra_package.name)

    if vim.fn.has("win32") == 1 then
      liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
      rust_analyzer_binary = { install_dir .. "/" .. "rust-analyzer" }
    elseif vim.fn.has("mac") == 1 then
      liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    else
      liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      rust_analyzer_binary = { install_dir .. "/" .. "rust-analyzer-x86_64-unknown-linux-gnu" }
    end
    adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
  end

  return {
    capabilities = function()
      require("config.utils").capabilities()
    end,
    server = {
      cmd = rust_analyzer_binary,
      auto_attach = true,
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "K", "<cmd>RustLsp hover actions<CR>", { buffer = bufnr, desc = "[Rust]: Hover Actions" })
        vim.keymap.set(
          "n",
          "<leader>la",
          "<cmd>RustLsp codeAction<CR>",
          { buffer = bufnr, desc = "[Rust]: Code Actions" }
        )
        vim.keymap.set(
          "n",
          "<leader>lre",
          "<cmd>RustLsp explainError<CR>",
          { buffer = bufnr, desc = "[Rust]: Explain Errors" }
        )
        vim.keymap.set(
          "n",
          "<leader>lrj",
          "<cmd>RustLsp joinLines<CR>",
          { buffer = bufnr, desc = "[Rust]: Join Lines" }
        )
        vim.keymap.set(
          "n",
          "<leader>lrd",
          "<cmd>RustLsp renderDiagnostic<CR>",
          { buffer = bufnr, desc = "[Rust]: Render Diagnostic as if cargo build" }
        )
        vim.keymap.set(
          "n",
          "<leader>ldd",
          "<cmd>RustLsp openDocs<CR>",
          { buffer = bufnr, desc = "[Rust]: Open Documentation" }
        )
        vim.keymap.set(
          "n",
          "<leader>e",
          "<cmd>RustLsp renderDiagnostic<CR>",
          { buffer = bufnr, desc = "[Rust]: Diagnostic" }
        )
        vim.keymap.set(
          "n",
          "<leader>gd",
          "<cmd>RustLsp relatedDiagnostics<CR>",
          { buffer = bufnr, desc = "[Rust]: [g]o to related [d]iagnostics" }
        )
      end,
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          semanticHighlighting = {
            strings = {
              -- disable because it overrides TreeSitter injections
              enable = false,
            },
          },
          -- cargo = { features = "all" },
          -- checkOnSave = true,
          -- check = { command = "clippy", features = "all" },
          -- procMacro = { enable = true },
        },
      },
    },
    tools = {
      autoSetHints = true,
      inlay_hints = {
        auto = true,
        show_parameter_hints = true,
        parameter_hints_prefix = " ",
        only_current_line = false,
        other_hints_prefix = " ",
      },
      on_initialized = function()
        vim.cmd([[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]])
      end,
    },
    dap = {
      adapter = adapter,
    },
  }
end

return setup_rust_lsp

-- Use LspAttach autocommand to only map the following keys
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local function map(mode, lhs, rhs, desc, opts)
      opts = opts or {}
      opts = vim.tbl_extend("force", opts, { desc = desc, silent = true, noremap = true })
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local opts = { buffer = ev.buf }

    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration", opts)
    map("n", "gd", vim.lsp.buf.definition, "Go to definition", opts)
    map("n", "K", vim.lsp.buf.hover, "Hover documentation", opts)
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation", opts)
    map("n", "<C-s>", vim.lsp.buf.signature_help, "Signature help", opts)
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder", opts)
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder", opts)
    map("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders", opts)
    map("n", "<space>D", vim.lsp.buf.type_definition, "Go to type definition", opts)
    map("n", "<space>rn", vim.lsp.buf.rename, "Rename symbol", opts)
    map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, "Code action", opts)
    map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostics", opts)
    map("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Set diagnostic loclist", opts)
    map(
      "n",
      "<C-n>",
      "<cmd>lua vim.diagnostic.jump { count = -1, float = true }<CR>",
      "Go to previous diagnostic",
      opts
    )
    map("n", "<C-p>", "<cmd>lua vim.diagnostic.jump { count = 1, float = true }<CR>", "Go to next diagnostic", opts)

    map("n", "<leader>dd", function()
      vim.diagnostic[vim.diagnostic.is_enabled() and "disable" or "enable"]()
      print("All diagnostics are " .. (vim.diagnostic.is_enabled() and "enabled" or "disabled"))
    end, "Toggle diagnostics", opts)

    -- code lens run
    map("n", "<leader>cl", vim.lsp.codelens.run, "Run code lens", opts)

    vim.diagnostic.config({
      virtual_text = true,
    })
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
-- Setup language servers.
local lspconfig = require("lspconfig")
local root_dir = function()
  return lspconfig.util.root_pattern(".git")(vim.fn.expand("%:p:h"))
end

local python_root_files = {
  "WORKSPACE", -- Bazel
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
}

-- Specific server configurations
local server_configs = {
  pyright = {
    root_dir = lspconfig.util.root_pattern(python_root_files),
    capabilities = capabilities,
  },

  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
    capabilities = capabilities,
  },

  graphql = {
    filetypes = { "graphql" },
    capabilities = capabilities,
  },

  elixirls = {
    cmd = { "elixir-ls" },
    root_dir = lspconfig.util.root_pattern("mix.exs", ".git"),
    capabilities = capabilities,
  },
}

-- Default setup for other language servers
local servers = {
  "pyright",
  "ts_ls",
  "cmake",
  "html",
  "cssls",
  "lua_ls",
  "bashls",
  "clangd",
  "gopls",
  "emmet_ls",
  "tailwindcss",
  "marksman",
  "graphql",
  "sqlls",
  "yamlls",
  "jsonls",
  "prismals",
  "dockerls",
  "docker_compose_language_service",
  "elixirls",
  "ruby_lsp",
}

-- Setup language servers
for _, lsp in ipairs(servers) do
  if server_configs[lsp] then
    -- If custom setup is provided
    if server_configs[lsp].setup_func then
      -- If a special setup function is provided
      server_configs[lsp].setup_func()
    else
      -- Use lspconfig with the defined configuration
      lspconfig[lsp].setup(server_configs[lsp])
    end
  else
    -- For servers without custom config, use default setup
    lspconfig[lsp].setup({
      capabilities = capabilities,
    })
  end
end

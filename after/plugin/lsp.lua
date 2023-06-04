require("mason").setup()

local servers = {
  "pyright",
  "tsserver",
  "cmake",
  "html",
  "cssls",
  "rust_analyzer",
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
}

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = false,
})

local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  local navbuddy = require("nvim-navbuddy")
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap(
    "n",
    "<leader>f",
    '<cmd>lua vim.lsp.buf.format({ filter = function(client) return client.name == "null-ls" end, bufnr = bufnr, })<CR>',
    opts
  )
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    root_dir = function()
      return vim.loop.cwd()
    end,
  })
end

local python_root_files = {
  "WORKSPACE", -- added for Bazel; items below are from default config
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
}

nvim_lsp["pyright"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = nvim_lsp.util.root_pattern(unpack(python_root_files)),
})

nvim_lsp["lua_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- LSP Diagnostics Toggle bindings
local nmap = require("config.keymap").nmap
nmap({ "<Leader>dd", "<cmd> ToggleDiag <cr>" })
nmap({ "<leader>du", "<Plug>(toggle-lsp-diag-underline)" })
nmap({ "<leader>ds", "<Plug>(toggle-lsp-diag-signs)" })
nmap({ "<leader>dv", "<Plug>(toggle-lsp-diag-vtext)" })
nmap({ "<leader>di", "<Plug>(toggle-lsp-diag-update_in_insert)" })

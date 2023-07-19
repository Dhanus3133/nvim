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
  "prismals",
  "dockerls",
  "docker_compose_language_service",
}

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = false,
})

local nvim_lsp = require("lspconfig")

local on_attach = function(_, bufnr)
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
    "<leader>k",
    '<cmd>lua vim.lsp.buf.format({ filter = function(client) return client.name == "null-ls" end, bufnr = bufnr, timeout_ms = 2000 })<CR>',
    opts
  )
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local root_dir = function()
  return nvim_lsp.util.root_pattern(".git")(vim.fn.expand("%:p:h"))
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

local rust_tools_config = {
  -- executor = require("rust-tools.executors").quickfix,

  inlay_hints = {
    auto = true,
    parameter_hints_prefix = " ",
    other_hints_prefix = " ",
  },
  dap = function()
    local install_root_dir = vim.fn.stdpath("data") .. "/mason"
    local extension_path = install_root_dir .. "/packages/codelldb/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

    return {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    }
  end,
}

local rust_tools_rust_server = {
  standalone = true,
  on_attach = on_attach,
  settings = {
    -- List of all options:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      check = {
        command = "cranky",
        -- extraArgs = { "--all", "--", "-W", "clippy::all" },
      },

      -- rust-analyzer.server.extraEnv
      -- neovim doesn"t have custom client-side code to honor this setting, it doesn't actually work
      -- https://github.com/neovim/nvim-lspconfig/issues/1735
      -- it's in init.vim as a real env variable
      --
      --	server = {
      --		extraEnv = {
      --			CARGO_TARGET_DIR = "target/rust-analyzer-check"
      --		}
      --	}
    },
  },
}

require("mason-lspconfig").setup_handlers({
  function(server_name)
    nvim_lsp[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_dir,
    })
  end,

  ["pyright"] = function()
    nvim_lsp["pyright"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = nvim_lsp.util.root_pattern(python_root_files),
    })
  end,

  ["graphql"] = function()
    nvim_lsp["graphql"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "graphql" },
    })
  end,

  ["rust_analyzer"] = function()
    require("rust-tools").setup({
      -- rust_tools specific settings
      tools = rust_tools_config,
      -- on_attach is actually bound server for rust-tools
      server = rust_tools_rust_server,
      -- I use lsp-status which adds itself to the capabilities table
      capabilities = capabilities,
    })
  end,

  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_dir,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
})

-- LSP Diagnostics Toggle bindings
local nmap = require("config.keymap").nmap
nmap({ "<Leader>dd", "<cmd> ToggleDiag <cr>" })
nmap({ "<leader>du", "<Plug>(toggle-lsp-diag-underline)" })
nmap({ "<leader>ds", "<Plug>(toggle-lsp-diag-signs)" })
nmap({ "<leader>dv", "<Plug>(toggle-lsp-diag-vtext)" })
nmap({ "<leader>di", "<Plug>(toggle-lsp-diag-update_in_insert)" })

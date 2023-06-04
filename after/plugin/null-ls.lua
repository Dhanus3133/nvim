require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",
    "autopep8",
    "prettier",
    "gofmt",
    "clang-format",
    "rustfmt",
    "shfmt",
    "markdownlint",
    "sqlfluff",
    "json_tool",
  },
})

local null_ls = require("null-ls")
local blt = null_ls.builtins

null_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  autostart = true,
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    blt.formatting.stylua.with({
      extra_args = { "--config-path", vim.fs.normalize("~/.config/nvim/.stylua.toml") },
    }),
    -- blt.formatting.black.with({ args = { "--quiet", "-" } }),
    blt.formatting.autopep8,
    blt.formatting.prettier,
    blt.formatting.gofmt,
    blt.formatting.clang_format,
    blt.formatting.rustfmt.with({
      extra_args = { "--edition=2021" },
    }),
    blt.formatting.shfmt,
    blt.formatting.markdownlint,
    blt.formatting.sqlfluff.with({
      extra_args = { "--dialect", "postgres" }, -- change to your dialect
    }),
    blt.formatting.json_tool,
  },
})

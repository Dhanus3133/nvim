return {
  formatters_by_ft = {
    lua = {
      "stylua",
      extra_args = { "--config-path", vim.fs.normalize("~/.config/nvim/.stylua.toml") },
    },
    python = { "black" },
    json = { "prettier", "json_tool" },
    go = {},
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = {
      "rustfmt",
      extra_args = { "--edition=2021" },
    },
    sh = {
      "shfmt",
      extra_args = { "-i", "2", "-ci", "-bn", "$FILENAME", "-w" },
    },
    markdown = { "markdownlint" },
    sql = {
      -- "sqlfluff",
      -- extra_args = { "--dialect", "postgres" },
    },
    css = { "stylelint" },
    scss = { "stylelint" },
    html = {
      "djlint",
      extra_args = { "--indent", "2", "--blank-line-after-tag", "load,extends,include,endblock" },
    },
  },

  stop_after_first = true,

  -- Optional: Formatting on save
  -- format_on_save = {
  --   timeout_ms = 1000,
  --   lsp_fallback = true,
  -- },
}

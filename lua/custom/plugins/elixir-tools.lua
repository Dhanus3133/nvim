return {
  "elixir-tools/elixir-tools.nvim",
  dependencies = {
    "elixir-editors/vim-elixir",
    "nvim-lua/plenary.nvim",
  },
  ft = { "elixir", "eex", "heex", "surface" },
  enabled = not vim.o.diff,
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    local register_keys = function()
      local wk = require("which-key")
      local bufnr = vim.api.nvim_get_current_buf()

      wk.register({
        p = { "<cmd>ElixirToPipe<cr>", "To Pipe" },
        P = { "<cmd>ElixirFromPipe<cr>", "From Pipe" },
        m = { "<cmd>ElixirExpandMacro<cr>", "Expand Macro" },
        r = { "<cmd>ElixirRestart<cr>", "Restart" },
        o = { "<cmd>ElixirOutputPanel<cr>", "Output Panel" },
      }, {
        prefix = "<leader>cE",
        name = "+elixir",
        buffer = bufnr,
      })
    end

    vim.api.nvim_create_autocmd(
      "FileType",
      { pattern = { "elixir", "eex", "heex", "surface" }, callback = register_keys }
    )

    elixir.setup({
      nextls = { enable = true },
      credo = { enable = true },
      elixirls = {
        cmd = require("mason-registry").get_package("elixir-ls"):get_install_path() .. "/language_server.sh",
        enable = true,
        settings = {
          elixirls.settings({
            dialyzerEnabled = false,
            dialyzerFormat = "dialyxir_long",
            -- dialyzerWarnOpts = []
            enableTestLenses = false,
            -- envVariables =
            fetchDeps = false,
            -- languageServerOverridePath =
            mixEnv = "dev",
            -- mixTarget = "host",
            -- projectDir = "",
            signatureAfterComplete = false,
            suggestSpecs = false,
            log_level = vim.lsp.protocol.MessageType.Log,
            message_level = vim.lsp.protocol.MessageType.Log,
            trace = {
              server = "off",
            },
          }),
        },
      },
    })
  end,
}

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "html",
    "css",
    "typescript",
    "javascript",
    "rust",
    "json",
    "yaml",
    "toml",
    "bash",
    "python",
    "cpp",
    "c",
    "cmake",
    "dockerfile",
    "go",
    "graphql",
    "haskell",
    "jsonc",
    "json5",
    "tsx",
    "vue",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
})

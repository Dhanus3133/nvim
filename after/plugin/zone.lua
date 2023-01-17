require("zone").setup({
  style = "epilepsy",
  after = 30, -- Idle timeout
  exclude_filetypes = { "TelescopePrompt" },

  treadmill = {
    direction = "left",
  },
  epilepsy = {
    stage = "ictal", -- "aura" or "ictal"
  },
})

require("trevj").setup({})

local nmap = require("config.keymap").nmap

nmap({ "<Leader>j", '<cmd>lua require("trevj").format_at_cursor()<CR>', { noremap = true, silent = true } })

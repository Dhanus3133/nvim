local nmap = require("config.keymap").nmap
nmap({ "<leader>cc", "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Close Buffer" } })

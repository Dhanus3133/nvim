require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

local nmap = require("config.keymap").nmap
nmap({ "ff", "<CMD>HopWord<CR>" })
nmap({ "fc", "<CMD>HopChar1CurrentLine<CR>" })
nmap({ "fl", "<CMD>HopLineStart<CR>" })
-- nmap({ "<S-j>", "<CMD>HopWordAC<CR>" })
-- nmap({ "<S-k>", "<CMD>HopWordBC<CR>" })

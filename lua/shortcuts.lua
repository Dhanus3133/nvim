keymap = vim.keymap.set

-- Move Line or block
local opts = { noremap = true, silent = true }
keymap('n', '<A-j>', ":m+<CR>", opts)
keymap('n', '<A-k>', ":m-2<CR>", opts)
keymap('v', '<A-j>', ":m \'>+1<CR>gv=gv", opts)
keymap('v', '<A-k>', ":m \'<-2<CR>gv=gv", opts)

-- Alt Backspace & Alt Del
keymap('i', '<M-BS>', "<C-w>", opts)
keymap('i', '<M-Del>', "<cmd>norm! dw<CR>", opts)

-- Bufferline bindings
keymap('n', 'f',        '<cmd> BufferLinePick <cr>')
keymap('n', 'F',        '<cmd> BufferLinePickClose <cr>')
keymap('n', '<TAB>',    '<cmd> BufferLineCycleNext <cr>')
keymap('n', '<S-TAB>',  '<cmd> BufferLineCyclePrev <cr>')
keymap('n', 'm.',       '<cmd> BufferLineMoveNext <cr>')
keymap('n', 'm,',       '<cmd> BufferLineMovePrev <cr>')

-- LSP Diagnostics Toggle bindings
keymap('n', '<Leader>dd', '<cmd> ToggleDiag <cr>')
keymap('n', '<leader>du', '<Plug>(toggle-lsp-diag-underline)')
keymap('n', '<leader>ds', '<Plug>(toggle-lsp-diag-signs)')
keymap('n', '<leader>dv', '<Plug>(toggle-lsp-diag-vtext)')
keymap('n', '<leader>di', '<Plug>(toggle-lsp-diag-update_in_insert)')


keymap('n', '<F7>', '<cmd> NvimTreeToggle <cr>')

keymap('n', '<Leader>p', '<cmd> Neoformat <cr>')

local nmap = require("config.keymap").nmap

require("bufferline").setup({
  options = {
    numbers = function(opts)
      return string.format("%s.", opts.ordinal)
    end,
    indicator = { icon = "▎", style = "icon" },
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "(" .. count .. ")"
    end,
    offsets = { { filetype = "NvimTree", text_align = "left" } },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    sort_by = "id",
  },
})

nmap({ "<leader>b", "<CMD>BufferLinePick<CR>" })
nmap({ "<leader>cb", "<CMD>BufferLinePickClose<CR>" })
nmap({ "<S-l>", "<CMD>BufferLineCycleNext<CR>" })
nmap({ "<S-h>", "<CMD>BufferLineCyclePrev<CR>" })
nmap({ "]b", "<CMD>BufferLineMoveNext<CR>" })
nmap({ "[b", "<CMD>BufferLineMovePrev<CR>" })
nmap({ "gs", "<CMD>BufferLineSortByDirectory<CR>" })
-- nmap {"f", "<cmd> BufferLinePick <cr>"}
-- nmap {"F", "<cmd> BufferLinePickClose <cr>"}
-- nmap {"<TAB>", "<cmd> BufferLineCycleNext <cr>"}
-- nmap {"<S-TAB>", "<cmd> BufferLineCyclePrev <cr>"}
-- nmap {"m.", "<cmd> BufferLineMoveNext <cr>"}
-- nmap {"m,", "<cmd> BufferLineMovePrev <cr>"}

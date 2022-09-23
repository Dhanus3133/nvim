require("iron.core").setup {
  config = {
    -- If iron should expose `<plug>(...)` mappings for the plugins
    should_map_plug = false,
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        command = {"zsh"}
      }
    },
    repl_open_cmd = require('iron.view').curry.bottom(40),
    -- how the REPL window will be opened, the default is opening
    -- a float window of height 40 at the bottom.
  },
  -- Iron doesn't set keymaps by default anymore. Set them here
  -- or use `should_map_plug = true` and map from you vim files
  keymaps = {
    send_motion = "<Leader>sc",
    visual_send = "<Leader>sc",
    send_file = "<Leader>sf",
    send_line = "<Leader>sl",
    send_mark = "<Leader>sm",
    mark_motion = "<Leader>mc",
    mark_visual = "<Leader>mc",
    remove_mark = "<Leader>md",
    cr = "<Leader>s<cr>",
    interrupt = "<Leader>s<Leader>",
    exit = "<Leader>sq",
    clear = "<Leader>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  }
}

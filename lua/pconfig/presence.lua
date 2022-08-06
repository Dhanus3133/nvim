-- include presence and its config
require('presence'):setup({
    auto_update = true,
    buttons = true,
    enable_line_number = false,
    main_image = 'file',
    neovim_image_text = 'Neovim',
    debounce_timeout = 10,
})

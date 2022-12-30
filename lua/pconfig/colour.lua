-- Material Theme config
vim.g.material_style = 'deep ocean'

require('material').setup({
	contrast = {
		sidebars = true,
		floating_windows = true,
	},
	italics = {
		keywords = true,
		functions = true,
	},
	contrast_filetypes = {
		'terminal',
		'packer',
		'qf',
	},
	disable = {
		borders = false,
		eob_lines = false 
	}
})
vim.api.nvim_command "colorscheme radium"

vim.cmd("highlight WinSeparator guifg=#c0bfbc")


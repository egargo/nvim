require('oil').setup({
	view_options = {
		case_sensitive = false,
		default_file_explorer = true,
		natural_order = false,
		show_hidden = true,
		sort = {
			{ 'type', 'desc' },
			{ 'name', 'asc' },
		},
	},
})

vim.keymap.set('n', '-', '<CMD>Oil<CR>')

require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			'%.git/',
			'%.direnv/',
			'%.venv/',
			'node_modules',
			'venv',
			'__pycache__',
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	},
})

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps)

vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		local path = vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
		if vim.uv.fs_stat(path .. '/build') == nil then
			vim.fn.jobstart({ 'make' }, { cwd = path })
		else
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('lazygit')
		end
	end
})

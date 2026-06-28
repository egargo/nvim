vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<left>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<right>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<up>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<down>', '<Nop>')

vim.keymap.set('n', '<leader>nc', function()
	require('telescope.builtin').find_files {
		cwd = vim.fn.stdpath('config')
	}
end)

vim.keymap.set('n', '<leader>lg', '<CMD>LazyGit<CR>')

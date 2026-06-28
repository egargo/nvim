vim.g.editorconfig = true
vim.opt.colorcolumn = "120"
vim.g.have_nerd_font = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.encoding = 'utf-8'
vim.opt.fileformat = 'unix'
vim.opt.list = true
vim.opt.listchars = {
	tab = '» ',
	trail = '·',
	lead = '·',
	nbsp = '␣',
}
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.spell = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.highlight.on_yank() end
})

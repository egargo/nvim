local language_servers = {
	'lua_ls',
	'gopls',
	'nil_ls',
	'pyright',
	'sqlls',
	'ts_ls',
	'yamlls',
	'zls',
}

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if not client:supports_method('textDocument/willSaveWaitUntil')
				and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})

local parsers = {
	'c',
	'lua',
	'go',
	'make',
	'nix',
	'python',
	'sql',
	'typescript',
	'yaml',
	'zig',
}

require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd('FileType', {
	pattern = parsers,
	callback = function() vim.treesitter.start() end,
})

require('mason').setup({
	log_level = vim.log.levels.OFF
})

require('mason-lspconfig').setup({
	ensure_installed = language_servers,
	automatic_installation = true,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
-- pcall(function()
-- 	capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
-- end)

vim.lsp.config('clangd', {
	capabilities = capabilities,
	cmd = { 'clangd' },
	filetypes = { 'c', 'cpp', 'compile_commands.json' },
	root_markers = { 'Makefile' },
	init_options = {
		fallbackFlags = { '--std=c23' }
	},
})

vim.lsp.config('lua_ls', {
	capabilities = capabilities,
	filetypes = { 'lua' },
	root_markers = { { '.emmyrc.json', '.luarc.json' }, '.git' },
	settings = {
		Lua = {
			completion = {
				callSnippet = 'Replace',
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
			runtime = {
				version = 'LuaJIT',
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

for _, server in ipairs(language_servers) do
	vim.lsp.config(server, {
		capabilities = capabilities
	})
end

vim.lsp.enable(language_servers)

require('blink.cmp').setup({
	fuzzy = {
		implementation = 'prefer_rust',
	},
	keymap = {
		preset = 'enter',
		['<Tab>'] = { 'select_next', 'fallback', },
		['<S-Tab>'] = { 'select_prev', 'fallback' },
		['<CR>'] = { 'select_and_accept', 'fallback' },
	},
	appearance = {
		nerd_font_variant = 'mono',
	},
	signature = { enabled = true },
	completion = {
		documentation = {
			auto_show = true,
		},
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},
		trigger = {
			show_on_keyword = true,
			show_on_trigger_character = true,
			show_on_insert_on_trigger_character = true,
			show_on_accept_on_trigger_character = true,
			show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
			show_on_x_blocked_trigger_characters = {
				"'", '"', '(', '{', '[', '.',
			},
			prefetch_on_insert = true,
		},
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
		providers = {
			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				score_offset = -3,
				opts = {
					friendly_snippets = true,
					global_snippets = { "all" },
				},
			},
		},
	},
})

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

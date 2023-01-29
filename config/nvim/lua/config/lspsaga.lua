require("lspsaga").setup({
	symbol_in_winbar = {
		enable = false,
	},
	code_action = {
		num_shortcut = false,
		keys = {
			quit = "<esc>",
		},
	},
	rename = {
		quit = "<esc>",
	},
	ui = {
		border = "single",
	},
})

vim.cmd([[
  augroup lspsaga_filetypes
    autocmd!
    autocmd FileType LspsagaHover nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  augroup END
]])

vim.diagnostic.config({
	virtual_text = false,
	underline = {
		severity = vim.diagnostic.severity.ERROR,
	},
	severity_sort = true,
})

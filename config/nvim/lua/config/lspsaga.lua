require("lspsaga").init_lsp_saga({
	-- require("lspsaga").setup({
	code_action_keys = {
		quit = "<esc>",
	},
	-- rename_action_keys = {
	-- 	quit = "<esc>",
	-- },
	rename_action_quit = "<esc>",
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

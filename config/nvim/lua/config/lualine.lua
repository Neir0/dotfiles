require("lualine").setup({
	theme = "onenord",
	options = {
		component_separators = {},
		section_separators = {},
	},
	sections = {
		lualine_b = { {
			"diagnostics",
			sources = { "nvim_lsp", "nvim_diagnostic" },
		}, "filename" },
		lualine_c = { "lsp_progress" },
		lualine_x = {
			{ "filetype", icon_only = true },
		},
	},
	extensions = {
		"fugitive",
		"nvim-tree",
		"quickfix",
	},
})

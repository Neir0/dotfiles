local colors = require("dracula").colors()

require("dracula").setup({
	italic_comment = true,
	overrides = {
		TelescopePromptBorder = { fg = colors.selection, bg = colors.selection },
		TelescopePromptNormal = {
			bg = colors.selection,
		},
		TelescopeNormal = { bg = colors.menu },
		TelescopePreviewTitle = {
			fg = colors.fg,
			bg = "NONE",
		},
		TelescopePromptTitle = {
			fg = colors.gray,
			bg = colors.green,
		},
		TelescopePreviewBorder = { fg = colors.menu, bg = colors.menu },
		TelescopeResultsBorder = { fg = colors.menu, bg = colors.menu },
	},
})

vim.cmd([[colorscheme dracula]])

local colors = require("onenord.colors").load()

require("onenord").setup({
	theme = "dark",
	-- fade_nc = true,
	styles = {
		comments = "italic,bold",
		keywords = "bold",
		diagnostics = "undercurl",
	},
	custom_highlights = {
		TelescopePromptBorder = { fg = colors.active, bg = colors.active },
		TelescopePromptNormal = {
			bg = colors.active,
		},
		TelescopeNormal = { bg = colors.float },
		TelescopePreviewTitle = {
			fg = colors.fg,
			bg = colors.none,
		},
		TelescopePromptTitle = {
			fg = colors.gray,
			bg = colors.green,
		},
		TelescopePreviewBorder = { fg = colors.float, bg = colors.float },
		TelescopeResultsBorder = { fg = colors.float, bg = colors.float },
	},
})

-- vim.pretty_print(TelescopePrompt)
-- for hl, col in pairs(TelescopePrompt) do
-- 	vim.api.nvim_set_hl(0, hl, col)
-- end

vim.cmd([[colorscheme onenord]])

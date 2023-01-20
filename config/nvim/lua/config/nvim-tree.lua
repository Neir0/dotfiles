require("nvim-tree").setup({
	disable_netrw = true,
	view = {
		width = 50,
		-- float = {
		-- 	enable = true,
		-- },
	},
	git = {
		enable = false,
	},
	renderer = {
		group_empty = true,
		highlight_opened_files = "name",
		special_files = {},
		icons = {
			webdev_colors = false,
		},
	},
	actions = {
		change_dir = {
			enable = false,
		},
		open_file = {
			quit_on_open = true,
		},
	},
})

-- vim.cmd([[
--   autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]])

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"typescript",
		"javascript",
		"jsdoc",
		"json",
		"css",
		"scss",
		"dockerfile",
		"html",
		"yaml",
		"bash",
		"lua",
	},

	highlight = {
		enable = true, -- TODO: wait for nord to support treesitter
	},

	textobjects = {
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},

		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},

	incremental_selection = {
		enable = true,
	},

	indent = {
		enable = false,
	},

	playground = {
		enable = false,
	},

	autotag = {
		enable = true,
	},
})

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		dynamic_preview_title = true,
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		path_display = { "truncate" },
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim",
		},
		preview = {
			treesitter = false,
		},
		mappings = {
			i = {
				["<C-u>"] = actions.results_scrolling_up,
				["<C-d>"] = actions.results_scrolling_down,
				["<PageUp>"] = actions.preview_scrolling_up,
				["<PageDown>"] = actions.preview_scrolling_down,
			},
			n = {
				["<C-u>"] = actions.results_scrolling_up,
				["<C-d>"] = actions.results_scrolling_down,
				["<PageUp>"] = actions.preview_scrolling_up,
				["<PageDown>"] = actions.preview_scrolling_down,

				["P"] = require("telescope.actions.layout").toggle_preview,
			},
		},
	},
	pickers = {
		buffers = {
			mappings = {
				n = {
					["d"] = "delete_buffer",
				},
			},
		},
		find_files = {
			disable_devicons = true,
			path_display = { "truncate" },
			mappings = {
				n = {
					["h"] = function(prompt_bufnr)
						local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
						local opts = {
							hidden = true,
							default_text = current_picker:_get_prompt(),
							-- TODO: copy other relevant state :/
						}

						require("telescope.actions").close(prompt_bufnr)
						require("telescope.builtin").find_files(opts)
					end,
				},
			},
		},
	},
})

require("telescope").load_extension("fzf")

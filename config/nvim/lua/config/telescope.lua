require("telescope").setup({
	defaults = {
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
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
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
	extensions = {
		-- executor = {
		--   commands = {
		--     { 'Buffer: Clear', '%d' },
		--     { 'Config: Re-source $MYVIMRC', { cmd = 'source', args = { '$MYVIMRC' } } },
		--     { 'Config: Re-source current file', { cmd = 'source', args = { '%' } } },
		--     { 'Coc: Restart', { cmd = 'CocRestart' } },
		--   }
		-- }
	},
})

-- require('telescope').load_extension('executor')
require("telescope").load_extension("fzf")

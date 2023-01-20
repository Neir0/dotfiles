local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,

	sources = {

		-- code actions
		--
		-- null_ls.builtins.code_actions.eslint_d,

		-- formatting
		--
		-- null_ls.builtins.formatting.eslint_d,

		null_ls.builtins.formatting.prettierd.with({
			extra_args = { "--no-editorconfig" },
		}),

		null_ls.builtins.formatting.stylua.with({
			condition = function(utils)
				return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
			end,
		}),

		-- diagnostics
		--
		-- null_ls.builtins.diagnostics.eslint_d,

		null_ls.builtins.diagnostics.selene.with({
			condition = function(utils)
				return utils.root_has_file({ "selene.toml" })
			end,
		}),
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})

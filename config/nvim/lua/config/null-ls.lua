local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- null_ls.builtins.diagnostics.eslint.with({
		-- 	condition = function(utils)
		-- 		return utils.root_has_file({ "angular.json", "nx.json" })
		-- 	end,
		-- }),

		null_ls.builtins.formatting.prettier.with({
			extra_args = { "--no-editorconfig" },
		}),

		null_ls.builtins.formatting.stylua.with({
			condition = function(utils)
				return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
			end,
		}),

		null_ls.builtins.diagnostics.selene.with({
			condition = function(utils)
				return utils.root_has_file({ "selene.toml" })
			end,
		}),
	},

	-- you can reuse a shared lspconfig on_attach callback here
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

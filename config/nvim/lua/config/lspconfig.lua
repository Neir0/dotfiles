require("mason-lspconfig").setup({
	ensure_installed = { "angularls", "cssls", "emmet_ls", "tsserver" },
	automatic_installation = true,
})

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- Add additional capabilities supported by nvim-cmp
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.tsserver.setup({
	capabilities = capabilities,
	init_options = {
		disableAutomaticTypingAcquisition = true,
		preferences = {
			importModuleSpecifierPreference = "project-relative",
		},
	},
})

lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	init_options = {
		html = {
			options = {
				["bem.enabled"] = false,
				["bem.element"] = "__",
				["bem.modifier"] = "--",
			},
		},
	},
})
--
-- lspconfig.jsonls.setup({
-- 	capabilities = capabilities,
-- })

lspconfig.cssls.setup({
	capabilities = capabilities,
})

-- lspconfig.html.setup({
-- 	capabilities = capabilities,
-- })
--
-- lspconfig.sumneko_lua.setup({
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				-- Make the server aware of Neovim runtime files
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			-- Do not send telemetry data containing a randomized but unique identifier
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })
--

--angularls
lspconfig.angularls.setup({
	capabilities = capabilities,
})

-- lspconfig.eslint.setup({
-- 	capabilities = capabilities,
-- 	settings = {
-- 		codeActionOnSave = {
-- 			enable = true,
-- 		},
-- 	},
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.tsx,*.ts,*.jsx,*.js",
-- 	command = "EslintFixAll",
-- })

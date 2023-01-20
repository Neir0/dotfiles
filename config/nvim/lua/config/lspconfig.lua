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

--angular
local cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	"./node_modules/typescript",
	-- "/Users/jveiga/.nvm/versions/node/v14.19.2/lib/node_modules/typescript",
	"--ngProbeLocations",
	"/Users/jveiga/.nvm/versions/node/v16.16.0/lib/node_modules/@angular/language-service",
}

lspconfig.angularls.setup({
	cmd = cmd,
	root_dir = util.root_pattern("angular.json", "nx.json"),
	capabilities = capabilities,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
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

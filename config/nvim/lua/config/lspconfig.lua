require("mason-lspconfig").setup({
	ensure_installed = { "angularls", "cssls", "emmet_ls", "tsserver", "eslint", "sumneko_lua" },
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
	-- handlers = {
	-- 	["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
	-- 		-- tsserver diagnostics to override because they're already handled by
	-- 		-- eslint plugin
	-- 		local to_ignore = function(code)
	-- 			return code == 6133 -- @typescript-eslint/no-unused-vars
	-- 		end
	--
	-- 		if result.diagnostics ~= nil then
	-- 			local idx = 1
	-- 			while idx <= #result.diagnostics do
	-- 				local code = result.diagnostics[idx].code
	-- 				if to_ignore(code) then
	-- 					table.remove(result.diagnostics, idx)
	-- 				else
	-- 					idx = idx + 1
	-- 				end
	-- 			end
	-- 		end
	--
	-- 		vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
	-- 	end,
	-- },
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

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

--angularls
lspconfig.angularls.setup({
	capabilities = capabilities,
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	-- settings = {
	-- 	format = {
	-- 		enable = true,
	-- 	},
	-- codeActionOnSave = {
	-- 	enable = true,
	-- },
	-- run = "onSave",
	-- },
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.tsx,*.ts,*.jsx,*.js",
	command = "EslintFixAll",
})

vim.diagnostic.config({
	virtual_text = {
		source = true,
		severity = { min = vim.diagnostic.severity.WARN },
		format = function(diag)
			return string.format("%s [%s]", diag.message, diag.code)
		end,
	},
	signs = false,
	underline = true,
	severity_sort = true,
	float = {
		source = true,
		format = function(diag)
			return string.format("%s [%s]", diag.message, diag.code)
		end,
	},
})

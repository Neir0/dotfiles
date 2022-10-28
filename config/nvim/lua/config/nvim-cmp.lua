local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			-- mode = "symbol",
		}),
	},
})

-- vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
-- 	callback = function()
-- 		local line = vim.api.nvim_get_current_line()
-- 		local cursor = vim.api.nvim_win_get_cursor(0)[2]
--
-- 		local current = string.sub(line, cursor, cursor + 1)
-- 		if current == "." or current == "," or current == " " then
-- 			require("cmp").close()
-- 		end
--
-- 		local before_line = string.sub(line, 1, cursor + 1)
-- 		local after_line = string.sub(line, cursor + 1, -1)
-- 		if not string.match(before_line, "^%s+$") then
-- 			if after_line == "" or string.match(before_line, " $") or string.match(before_line, "%.$") then
-- 				require("cmp").complete()
-- 			end
-- 		end
-- 	end,
-- 	pattern = "*",
-- })

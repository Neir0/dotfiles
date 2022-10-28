P = function(v)
	print(vim.inspect(v))
end

vim.cmd("colorscheme onenord")

require("options")
require("plugins")
require("mappings")

-- telescope
-- vim.api.nvim_set_hl(0, "TelescopeMatching", { link = "SpecialChar" }) -- FIX for nord :/

-- -- nvim-dap
-- local dap = require("dap")
-- dap.adapters.node2 = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { os.getenv("HOME") .. "/projects/vscode-node-debug2/out/src/nodeDebug.js" },
-- }
--
-- dap.configurations.javascript = {
-- 	{
-- 		name = "Launch",
-- 		type = "node2",
-- 		request = "launch",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		console = "integratedTerminal",
-- 	},
-- 	{
-- 		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
-- 		name = "Attach to process",
-- 		type = "node2",
-- 		request = "attach",
-- 		processId = require("dap.utils").pick_process,
-- 	},
-- }
--
-- require("dapui").setup({})
--
-- nmap("<leader>dd", '<cmd>lua require("dap").continue()<cr>')
-- nmap("<leader>ds", '<cmd>lua require("dap").step_over()<cr>')
-- nmap("<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<cr>')

-- Fix syntax highlight for large files
vim.cmd([[autocmd BufEnter * :syntax sync fromstart]])

-- autocommands
-- vim.api.nvim_create_autocmd('BufRead', {
--   pattern = '*',
--   command = 'normal zizi'
-- })

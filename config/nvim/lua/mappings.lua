local function map(mode, shortcut, command)
	vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

-- vim.keymap.set("n", "<esc>", function()
-- 	retard_esc = (retard_esc or 0) + 1
-- 	print("Retarded <esc> #: " .. retard_esc)
-- end, {})

local function nmap(shortcut, command)
	map("n", shortcut, command)
end

-- my remaps
nmap("<leader>s", ":w<cr>")
nmap("<leader>BB", "<cmd>echo expand('%:p')<cr>")
nmap("<leader>Bp", '<cmd>let @+ = expand("%:p")<cr>')
nmap("<leader>Bd", '<cmd>let @+ = expand("%:p:h")<cr>')
nmap("<esc>", "<cmd>noh<cr>")

-- folding
nmap("<leader>zz", "zxzR")

-- telescope
nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<leader>fa", "<cmd>Telescope live_grep only_sort_text=true<cr>")
nmap("<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
nmap("<leader>fw", "<cmd>Telescope grep_string<cr>")
nmap("<leader>fb", "<cmd>Telescope git_branches<cr>")
nmap("<leader>fc", "<cmd>Telescope git_commits<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nmap("<leader>fC", "<cmd>Telescope commands<cr>")
nmap("<leader>fR", "<cmd>Telescope resume<cr>")

-- nvim-tree
nmap("<leader>nt", "<cmd>NvimTreeToggle<cr>")
nmap("<leader>nf", "<cmd>NvimTreeFocus<cr>")
nmap("<leader>nh", "<cmd>NvimTreeFindFileToggle<cr>")

-- fugitive
nmap("<leader>GG", ":Ge :<cr>")
nmap("<leader>Gg", ":Ge :<cr>")
nmap("<leader>Gc", ":G commit<cr>")
nmap("<leader>Gp", ":G push<cr>")
nmap("<leader>Gl", ":G pull<cr>")
nmap("<leader>Gb", ":G blame<cr>")

-- hop
map({ "n", "x" }, "s", "<cmd>HopChar2<cr>")

-- quickfix/location lists
nmap("<leader>cn", "<cmd>cnext<cr>")
nmap("<leader>cp", "<cmd>cprevious<cr>")
nmap("<leader>cc", "<cmd>cclose<cr>")
nmap("<leader>ln", "<cmd>lnext<cr>")
nmap("<leader>lp", "<cmd>lprevious<cr>")
nmap("<leader>lc", "<cmd>lclose<cr>")

-- window management
nmap("<leader>wv", "<cmd>wincmd v<cr>")
nmap("<leader>wr", "<cmd>wincmd r<cr>")
nmap("<leader>wp", "<cmd>wincmd p<cr>")
-- nmap("<leader>wh", "<cmd>wincmd h<cr>")
-- nmap("<leader>wl", "<cmd>wincmd l<cr>")
-- nmap("<leader>wj", "<cmd>wincmd j<cr>")
-- nmap("<leader>wk", "<cmd>wincmd k<cr>")

-- buffer management
nmap("<leader>bl", "<cmd>Telescope buffers<cr>")
nmap("<leader>bp", "<cmd>bp<cr>")
nmap("<leader>bd", "<cmd>BDelete this<cr>")
nmap("<leader>ba", "<cmd>BDelete all<cr>")
nmap("<leader>bo", "<cmd>BDelete other<cr>")

-- lsp
nmap("<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
nmap("<leader>gi", "<cmd>Telescope lsp_implementations<cr>")
-- nmap('<leader>gvd', '<cmd>vsp<cr><plug>(coc-definition)')
nmap("<leader>gs", "<cmd>Telescope lsp_document_symbols<cr>")
nmap("<leader>gS", "<cmd>Telescope lsp_workspace_symbols<cr>")
nmap("<leader>gr", "<cmd>Telescope lsp_references<cr>")
nmap("<leader>gD", "<cmd>Telescope diagnostics<cr>")
-- nmap("<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")
nmap("<leader>ga", "<cmd>Lspsaga code_action<cr>")
-- nmap("<leader>gR", "<cmd>lua vim.lsp.buf.rename()<cr>")
nmap("<leader>gR", "<cmd>Lspsaga rename<cr>")
nmap("<leader>ge", "<cmd>lua vim.diagnostic.open_float()<cr>")
nmap(
	"[e",
	"<cmd>lua vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN }, float = false })<cr>"
)
nmap(
	"]e",
	"<cmd>lua vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN }, float = false })<cr>"
)
nmap("[d", "<cmd>lua vim.diagnostic.goto_prev({ float = { severity = { max = vim.diagnostic.severity.INFO } } })<cr>")
nmap("]d", "<cmd>lua vim.diagnostic.goto_next({ float = { severity = { max = vim.diagnostic.severity.INFO } } })<cr>")
nmap("K", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- ng
local ng = require("ng")
nmap("<leader>at", ng.goto_template_for_component)
nmap("<leader>ac", ng.goto_component_with_template_file)
nmap("<leader>aT", ng.get_template_tcb)

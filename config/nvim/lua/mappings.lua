function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- my remaps
nmap('<leader>s', ':w<cr>')
nmap('<leader>jd', ':call CocAction("runCommand", "docthis.documentThis")<cr>')

-- telescope
nmap('<leader>fo', '<cmd>Telescope resume<cr>')
nmap('<leader>ff', '<cmd>Telescope find_files<cr>')
nmap('<leader>fa', '<cmd>Telescope live_grep only_sort_text=true<cr>')
nmap('<leader>fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nmap('<leader>fw', '<cmd>Telescope grep_string<cr>')
nmap('<leader>fb', '<cmd>Telescope git_branches<cr>')
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>')
nmap('<leader>fc', '<cmd>Telescope commands<cr>')

-- telescope-coc
nmap('<leader>gs', '<cmd>Telescope coc document_symbols<cr>')
nmap('<leader>gS', '<cmd>Telescope coc workspace_symbols<cr>')
nmap('<leader>gr', '<cmd>Telescope coc references<cr>')

-- nvim-tree
nmap('<leader>nt', '<cmd>NvimTreeToggle<cr>')
nmap('<leader>nf', '<cmd>NvimTreeFocus<cr>')
nmap('<leader>nh', '<cmd>NvimTreeFindFile<cr>')

-- fugitive
nmap('<leader>GG', ':Ge :<cr>')
nmap('<leader>Gg', ':Ge :<cr>')
nmap('<leader>Gc', ':G commit<cr>')
nmap('<leader>Gp', ':G push<cr>')
nmap('<leader>Gl', ':G pull<cr>')
nmap('<leader>Gb', ':G blame<cr>')

-- hop
nmap('s', '<cmd>HopChar2<cr>')

-- quickfix/location lists
nmap('<leader>cn', '<cmd>cnext<cr>')
nmap('<leader>cp', '<cmd>cprevious<cr>')
nmap('<leader>cc', '<cmd>cclose<cr>')
nmap('<leader>ln', '<cmd>lnext<cr>')
nmap('<leader>lp', '<cmd>lprevious<cr>')
nmap('<leader>lc', '<cmd>lclose<cr>')

-- window management
nmap('<leader>wv', '<cmd>wincmd v<cr>')
nmap('<leader>wr', '<cmd>wincmd r<cr>')
nmap('<leader>wp', '<cmd>wincmd p<cr>')
nmap('<leader>wh', '<cmd>wincmd h<cr>')
nmap('<leader>wl', '<cmd>wincmd l<cr>')
nmap('<leader>wj', '<cmd>wincmd j<cr>')
nmap('<leader>wk', '<cmd>wincmd k<cr>')

-- buffer management
nmap('<leader>bl', '<cmd>Telescope buffers<cr>')
nmap('<leader>bp', '<cmd>bp<cr>')
nmap('<leader>bd', '<cmd>BDelete this<cr>')
nmap('<leader>ba', '<cmd>BDelete all<cr>')
nmap('<leader>bo', '<cmd>BDelete other<cr>')

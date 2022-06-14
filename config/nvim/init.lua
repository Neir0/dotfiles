-- options
vim.g['coc_global_extensions'] = {
  'coc-tsserver',
  'coc-angular',
  'coc-prettier',
  'coc-css',
  'coc-json',
  'coc-html',
  'coc-snippets',
  'coc-spell-checker',
  'coc-emmet',
  'coc-sumneko-lua',
  'coc-sh',
  'coc-docthis'
}

P = function(v)
  print(vim.inspect(v))
end

vim.cmd('colorscheme nord')

require('options')
require('plugins')
require('mappings')

-- telescope
vim.api.nvim_set_hl(0, 'TelescopeMatching', { link = 'SpecialChar' }) -- FIX for nord :/

-- nvim-dap
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/projects/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require 'dap.utils'.pick_process,
  },
}

require('dapui').setup {}

nmap('<leader>dd', '<cmd>lua require("dap").continue()<cr>')
nmap('<leader>ds', '<cmd>lua require("dap").step_over()<cr>')
nmap('<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<cr>')

--  goto code navigation.
nmap('<leader>gd', '<plug>(coc-definition)')
nmap('<leader>gvd', '<cmd>vsp<cr><plug>(coc-definition)')
nmap('<leader>ga', '<plug>(coc-codeaction-cursor)')
nmap('<leader>gn', '<plug>(coc-diagnostic-next-error)')
nmap('<leader>gp', '<plug>(coc-diagnostic-prev-error)')
nmap('<leader>gR', '<plug>(coc-rename)')
nmap('[g', '<plug>(coc-diagnostic-prev)')
nmap(']g', '<plug>(coc-diagnostic-next)')

nmap('K', ':call ShowDocumentation()<cr>')

-- coc-angular
nmap('<leader>gc', ":call CocAction('runCommand', 'angular.goToComponentWithTemplateFile')<cr>")
nmap('<leader>gt', ":call CocAction('runCommand', 'angular.goToTemplateForComponent')<cr>")

-- use <c-space> to trigger completion.
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', { noremap = true, silent = true, expr = true })

-- make <cr> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
vim.api.nvim_set_keymap('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<cr><c-r>=coc#on_enter()<cr>"', {
  noremap = true,
  silent = true,
  expr = true
})

vim.cmd([[
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" coc-snippets
" vmap <leader>w <Plug>(coc-snippets-select)
" imap <C-s> <Plug>(coc-snippets-expand)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_snippet_next = '<tab>'

" nvim-tree
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" Fix syntax highlight for large files
autocmd BufEnter * :syntax sync fromstart
]])

-- autocommands
-- vim.api.nvim_create_autocmd('BufRead', {
--   pattern = '*',
--   command = 'normal zizi'
-- })

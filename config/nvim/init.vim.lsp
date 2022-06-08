set clipboard=unnamed
set confirm
set cursorline
set foldcolumn=2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set hidden
set ignorecase
set mouse=a
set nobackup
set noshowmode
set nowrap
set nowritebackup
set number relativenumber
set redrawtime=20000
set shiftwidth=2
set signcolumn=number
set smartcase
set splitright
set tabstop=2
set shiftwidth=2 
set expandtab
set termguicolors
set updatetime=300
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

let g:sneak#label=1
" let g:airline_extensions = ['coc', 'fzf']
let g:nvim_tree_group_empty=1
let g:nvim_tree_special_files={}
let g:nvim_tree_highlight_opened_files=2
let g:nvim_tree_show_icons={
  \ 'folders': 0
  \ }

nnoremap <SPACE> <Nop>
let mapleader=" "

call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig' 
Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'asheq/close-buffers.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'arcticicestudio/nord-vim'
Plug 'lilydjwg/colorizer'
Plug 's1n7ax/nvim-terminal'
" Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

colorscheme nord

" My remaps!
imap jj <Esc>
nnoremap <leader>s :w<CR>
nnoremap <leader>GG :Ge :<cr>
nnoremap <leader>Gg :Ge :<cr>
nnoremap <leader>Gc :G commit<cr>
nnoremap <leader>Gp :G push<cr>
nnoremap <leader>Gl :G pull<cr>
nnoremap <leader>Gb :G blame<cr>

" Terminal
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
nnoremap <leader>co :terminal<cr>
nnoremap <leader>cv :vsplit\|:terminal<cr>

" FZF
nnoremap <leader>ff <cmd>Telescope find_files<cr> 
nnoremap <leader>fl <cmd>Telescope buffers<cr> 
nnoremap <leader>fa <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>GBranches<cr>
nnoremap <leader>fh <cmd>Helptags<cr>

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Quickfix/Location lists
nnoremap <leader>qn <cmd>cnext<cr>
nnoremap <leader>qp <cmd>cprevious<cr>
nnoremap <leader>qc <cmd>cclose<cr>
nnoremap <leader>ln <cmd>lnext<cr>
nnoremap <leader>lp <cmd>lprevious<cr>
nnoremap <leader>lc <cmd>lclose<cr>

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" " GoTo code navigation.
" nmap <silent> <leader>gvd :vsp<cr><Plug>(coc-definition)
" nmap <silent> <leader>gD <Plug>(coc-type-definition)
" nmap <silent> <leader>gi <Plug>(coc-implementation)
" nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
" nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
"
" " coc-angular
" nnoremap <silent> <leader>gc :call CocAction('runCommand', 'angular.goToComponentWithTemplateFile')<cr>
" nnoremap <silent> <leader>gt :call CocAction('runCommand', 'angular.goToTemplateForComponent')<cr>


lua <<EOF
-- nvim-cmp
local cmp = require'cmp'
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lsp
local opts = { noremap=true, silent=true }
-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


local servers = {  'cssls', 'jsonls', 'emmet_ls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- tsserver
require'lspconfig'.tsserver.setup{
  init_options = {
    disableAutomaticTypingAcquisition = true,
    preferences = {
      importModuleSpecifierPreference = 'project-relative'
    }
  },
  on_attach = on_attach,
  capabilities = capabilities
}

-- angularls
local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  "./node_modules/typescript",
  "--ngProbeLocations",
  "/Users/jveiga/.nvm/versions/node/v14.19.2/lib/node_modules/@angular/language-service",
}

require'lspconfig'.angularls.setup{
  cmd = cmd,
  on_attach = on_attach,
  capabilities = capabilities,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = cmd
  end,
}

-- nvim-lsputils

-- treesitter
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "typescript", "html", "javascript", "json", "css", "scss", "dockerfile", "lua", "yaml" },

  highlight = {
    enable = false, -- TODO: wait for nord to support treesitter
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },

    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },

  indent = {
    enable = false
  }
}

-- nvim-tree
require 'nvim-tree'.setup {
  disable_netrw = true,
  view = {
    width = 50 
  },
  git = {
    enable = false
  }
}

-- lualine
require 'lualine'.setup {
  options = { section_separators = '', component_separators = '' },
  sections = {
    lualine_b = { 'diagnostics' },
    lualine_c = { 'lsp_progress' },
    lualine_x = { 'filetype' },
  },
  extensions = { 'nvim-tree', 'fugitive', 'quickfix' }
}

-- telescope
require 'telescope'.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true      -- override the file sorter
    }
  },
  pickers = {
    grep_string = {
      only_sort_text = true
    }
  }
}
require 'telescope'.load_extension('fzf')

-- nvim-terminal
require 'nvim-terminal'.setup {}
EOF

" Window management
nnoremap <silent> <leader>wv :wincmd v<CR>
nnoremap <silent> <leader>wr :wincmd r<CR>
nnoremap <silent> <leader>wp :wincmd p<CR>
nnoremap <silent> <leader>wh :wincmd h<CR>
nnoremap <silent> <leader>wl :wincmd l<CR>
nnoremap <silent> <leader>wj :wincmd j<CR>
nnoremap <silent> <leader>wk :wincmd k<CR>

" Buffer management
nnoremap <leader>bl :Buffers<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bd :Bdelete this<CR>
nnoremap <leader>ba :Bdelete all<CR>
nnoremap <leader>bo :Bdelete other<cr>

" Folds
nmap <leader>zf zfaf

" " Coc
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"
" " coc-fzf
" nnoremap <silent> <leader>gs :<C-u>CocFzfList outline<CR>
" nnoremap <silent> <leader>gg :<C-u>CocFzfListResume<CR>

" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" " Symbol renaming.
" nmap <F2> <Plug>(coc-rename)
"
" " coc-snippets
" " vmap <leader>w <Plug>(coc-snippets-select)
" " imap <C-s> <Plug>(coc-snippets-expand)
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" let g:coc_snippet_next = '<tab>'

" nvim-tree
nnoremap <leader>nt <cmd>NvimTreeToggle<CR>
nnoremap <leader>nf <cmd>NvimTreeFocus<CR>
nnoremap <leader>nh <cmd>NvimTreeFindFile<CR>
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" Fix syntax highlight for large files
autocmd BufEnter * :syntax sync fromstart


-- options
vim.o.clipboard = 'unnamed'
vim.o.confirm = true
vim.o.cursorline = true
vim.o.foldenable = false
vim.o.foldcolumn = '2'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.ignorecase = true
vim.o.mouse = 'a'
vim.o.backup = false
vim.o.writebackup = false
vim.o.showmode = false
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.redrawtime = 20000
vim.o.shiftwidth = 2
vim.o.signcolumn = 'number'
vim.o.smartcase = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.updatetime = 300
vim.o.grepprg = 'ag --vimgrep $*'
vim.o.grepformat = '%f:%l:%c:%m'

-- globals
vim.g.mapleader = ' '
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
  'coc-sh'
}

P = function(v)
  print(vim.inspect(v))
end

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'neoclide/jsonc.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'fannheyward/telescope-coc.nvim'
  use 'windwp/nvim-autopairs'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'phaazon/hop.nvim'
  use 'kazhala/close-buffers.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  use 'arcticicestudio/nord-vim'
  use 'norcalli/nvim-colorizer.lua'

  -- local plugins
  -- use '~/projects/neovim-plugins/test.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd('colorscheme nord')

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- my remaps
nmap('<leader>s', ':w<cr>')
nmap('<leader>jd', ':call CocAction("runCommand", "docthis.documentThis")<cr>')

-- fugitive
nmap('<leader>GG', ':Ge :<cr>')
nmap('<leader>Gg', ':Ge :<cr>')
nmap('<leader>Gc', ':G commit<cr>')
nmap('<leader>Gp', ':G push<cr>')
nmap('<leader>Gl', ':G pull<cr>')
nmap('<leader>Gb', ':G blame<cr>')

-- telescope
require('telescope').setup {
  defaults = {
    layout_config = {
      prompt_position = 'top'
    },
    sorting_strategy = 'ascending',
    path_display = { 'smart' },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    },
    preview = {
      treesitter = false
    }
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<c-d>'] = 'delete_buffer'
        }
      }
    }
  }
}

require('telescope').load_extension('fzf')

nmap('<leader>ff', '<cmd>Telescope find_files<cr>')
nmap('<leader>fa', '<cmd>Telescope live_grep only_sort_text=true<cr>')
nmap('<leader>fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nmap('<leader>fb', '<cmd>Telescope git_branches<cr>')
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>')

vim.api.nvim_set_hl(0, 'TelescopeMatching', { link = 'SpecialChar' }) -- FIX for nord :/

-- telescope-coc
require('telescope').load_extension('coc')

nmap('<leader>gs', '<cmd>Telescope coc document_symbols<cr>')
nmap('<leader>gS', '<cmd>Telescope coc workspace_symbols<cr>')
nmap('<leader>gr', '<cmd>Telescope coc references<cr>')

-- nvim-autopairs
require 'nvim-autopairs'.setup {}

-- treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "html", "javascript", "json", "css", "scss", "dockerfile", "lua", "yaml", "bash" },

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
  },

  playground = {
    enable = true
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
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = 'name',
    special_files = {}
  }
}

-- lualine
require 'lualine'.setup {
  options = {
    component_separators = {},
    section_separators = {}
  },
  sections = {
    lualine_b = { 'diagnostics', 'filename' },
    lualine_c = { 'g:coc_status' },
    lualine_x = {
      { 'filetype', icon_only = true }
    }
  },
  extensions = {
    'fugitive',
    'nvim-tree',
    'quickfix'
  }
}

nmap('<leader>nt', '<cmd>NvimTreeToggle<cr>')
nmap('<leader>nf', '<cmd>NvimTreeFocus<cr>')
nmap('<leader>nh', '<cmd>NvimTreeFindFile<cr>')

-- close-buffers.nvim
require 'close_buffers'.setup {}

-- nvim-colorizer
require 'colorizer'.setup { 'html', 'css', 'scss' }

-- hop.nvim
require 'hop'.setup {}
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

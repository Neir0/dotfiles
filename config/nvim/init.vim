set clipboard=unnamed
set confirm
set cursorline
set foldcolumn=2
set hidden
set ignorecase
" set list
" set listchars=extends:➥,precedes:➥,nbsp:␣
set noshowmode
set nowrap
set number relativenumber
set nu rnu
set redrawtime=20000
set shiftwidth=2
set smartcase
set splitright
set tabstop=2

let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
" let g:gruvbox_italic=1
" let g:gruvbox_invert_selection=0
let g:sneak#label=1
let g:vimspector_install_gadgets = [ 'vscode-node-debug2', 'debugger-for-chromedebugpy']
let g:vimspector_enable_mappings = 'HUMAN'
let g:git_messenger_always_into_popup=1
let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_popup_content_margins = v:false
nnoremap <SPACE> <Nop>
let mapleader=" "

call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'puremourning/vimspector'
Plug 'justinmk/vim-sneak'
Plug 'asheq/close-buffers.vim'
Plug 'mattn/emmet-vim'
Plug 'rhysd/git-messenger.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'vim-test/vim-test'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Color scheme
colorscheme nord

" My remaps!
imap jj <Esc>
nnoremap <leader>s :w<CR>
nnoremap <leader>G :Ge :<cr>

" Terminal
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
nnoremap <leader>to :terminal<cr>
nnoremap <leader>tv :vsplit\|:terminal<cr>

" Find
nnoremap <leader>ff :Files<CR> 
nnoremap <leader>fl :BLines<CR> 
nnoremap <leader>fa :Ag<CR> 

" Treesitter
lua <<EOF
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
    enable = true
  }
}
EOF

" Window management
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>wr :wincmd r<CR>
nnoremap <leader>wp :wincmd p<CR>
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wl :wincmd l<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>

" Buffer management
nnoremap <leader>bl :Buffers<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bd :Bdelete this<CR>
nnoremap <leader>ba :Bdelete all<CR>
nnoremap <leader>bo :Bdelete other<cr>

" Folds
nmap <leader>zf zfaf

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gvd :vsp<cr><Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gs :CocList outline<CR>
nmap <silent> <leader>ga :CocAction<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" coc-snippets
" vmap <leader>w <Plug>(coc-snippets-select)
" imap <C-s> <Plug>(coc-snippets-expand)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Vimspector
nnoremap <leader>dd :call vimspector#Launch()<cr>
nnoremap <leader>ds :call vimspector#Reset()<cr>
nnoremap <leader>dwc :call win_gotoid(g:vimspector_session_windows.code)<cr>
nnoremap <leader>dww :call win_gotoid(g:vimspector_session_windows.watches)<cr>
nnoremap <leader>dwv :call win_gotoid(g:vimspector_session_windows.variables)<cr>

" NERDTree
let NERDTreeWinSize=50
nnoremap <leader>tf <cmd>NERDTreeFocus<cr>
nnoremap <leader>th <cmd>NERDTreeFind<cr>
nnoremap <leader>tt <cmd>NERDTreeToggle<cr>

" Test
let g:test#javascript#runner = 'jest'
let test#enabled_runners = ["javascript#jest"]

" Fix syntax highlight for large files
" autocmd BufEnter * :syntax sync fromstart
"

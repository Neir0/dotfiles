set clipboard=unnamed
set confirm
set cursorline
set foldcolumn=2
set hidden
set ignorecase
" set list
" set listchars=extends:➥,precedes:➥,nbsp:␣
set mouse=a
set nobackup
set noshowmode
set nowrap
set nowritebackup
set number relativenumber
set nu rnu
set redrawtime=20000
set shiftwidth=2
set signcolumn=number
set smartcase
set splitright
set tabstop=2
set tabstop=2 
set shiftwidth=2 
set expandtab
set termguicolors
set updatetime=300

" let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
" let g:gruvbox_italic=1
" let g:gruvbox_invert_selection=0
let g:sneak#label=1
let g:git_messenger_always_into_popup=1
let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_popup_content_margins = v:false
let g:airline_extensions = ['coc', 'fzf']
nnoremap <SPACE> <Nop>
let mapleader=" "

call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'neoclide/jsonc.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-test/vim-test'
" Plug 'tpope/vim-dispatch'
" Plug 'neomake/neomake'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

call plug#end()

colorscheme nord

" My remaps!
imap jj <Esc>
nnoremap <leader>s :w<CR>
nnoremap <leader>G :Ge :<cr>
nnoremap <leader>jd :call CocAction('runCommand', 'docthis.documentThis')<cr>

" Terminal
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
nnoremap <leader>co :terminal<cr>
nnoremap <leader>cv :vsplit\|:terminal<cr>

" FZF
nnoremap <leader>ff <cmd>Files<cr> 
nnoremap <leader>fl <cmd>BLines<cr> 
nnoremap <leader>fa <cmd>Ag<cr>
nnoremap <leader>fb <cmd>GBranches<cr>

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
    enable = false
  }
}
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

" Coc
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
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gvd :vsp<cr><Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gs :CocList outline<CR>
nmap <silent> <leader>ga :CocAction<CR>
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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
let g:vimspector_install_gadgets = [ 'vscode-node-debug2', 'debugger-for-chromedebugpy']
let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>dd :call vimspector#Launch()<cr>
nmap <leader>ds :call vimspector#Reset()<cr>
nmap <leader>dwc :call win_gotoid(g:vimspector_session_windows.code)<cr>
nmap <leader>dww :call win_gotoid(g:vimspector_session_windows.watches)<cr>
nmap <leader>dwv :call win_gotoid(g:vimspector_session_windows.variables)<cr>
nmap <leader>dws :call win_gotoid(g:vimspector_session_windows.stack_trace)<cr>
nmap <leader>dT :call vimspector#LaunchWithSettings(#{ configuration: 'UI Test - Launch (File)' })<cr>
nmap <leader>di <plug>VimspectorBalloonEval
nmap <leader><F11> <plug>VimspectorUpFrame
nmap <leader><F12> <plug>VimspectorDownFrame

" Test
let g:test#javascript#runner = 'jest'
let test#enabled_runners = ["javascript#jest", "javascript#cypress"]

" Test/Vimspector Jest integration
function! JestTestNearestStrategy(cmd)
  let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  call vimspector#LaunchWithSettings( #{ configuration: 'UI Test - Launch (Nearest)', TestName: testName } )
endfunction

let g:test#custom_strategies = {'jest_nearest': function('JestTestNearestStrategy')}
nnoremap <leader>dt <cmd>TestNearest -strategy=jest_nearest<cr>

" Ultest
let g:ultest_use_pty = 1
let g:ultest_summary_width = 70
let g:ultest_output_on_line = 0
" NOTE: we'll need to activate this if we want to support describe(MyComponent.name, () => { ... }) syntax in our jest spec files.
" let g:ultest_disable_grouping = ['javascript#jest']

nmap <silent> <leader>tt <plug>(ultest-summary-toggle)
nmap <silent> <leader>tf <plug>(ultest-summary-jump)
nmap <silent> <leader>th <plug>(ultest-run-nearest)
nmap <silent> <leader>tr <plug>(ultest-run-file)
nmap <silent> <leader>tn <plug>(ultest-next-fail)
nmap <silent> <leader>tp <plug>(ultest-prev-fail)
nmap <silent> <leader>to <cmd>UltestOutput<cr>

" NERDTree
let NERDTreeWinSize=50
nnoremap <leader>nf <cmd>NERDTreeFocus<cr>
nnoremap <leader>nh <cmd>NERDTreeFind<cr>
nnoremap <leader>nt <cmd>NERDTreeToggle<cr>

" Fix syntax highlight for large files
autocmd BufEnter * :syntax sync fromstart


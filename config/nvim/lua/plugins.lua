local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- local plugins
  -- use '~/projects/neovim-plugins/telescope-executor.nvim'
  use '~/projects/neovim-plugins/plenary.nvim'
  use { '~/projects/neovim-plugins/telescope.nvim', config = get_config('telescope') }
  --
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'neoclide/jsonc.vim'
  -- use 'nvim-lua/plenary.nvim'
  -- use({ 'nvim-telescope/telescope.nvim', config = get_config('telescope') })
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'fannheyward/telescope-coc.nvim'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use { 'windwp/nvim-autopairs', config = get_config('autopairs') }
  use 'kyazdani42/nvim-web-devicons'
  use { 'kyazdani42/nvim-tree.lua', config = get_config('nvim-tree') }
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use { 'phaazon/hop.nvim', config = get_config('hop') }
  use { 'kazhala/close-buffers.nvim', config = get_config('close-buffers') }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = get_config('lualine')
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = get_config('treesitter') }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-angular'
  use 'nvim-treesitter/playground'
  use 'arcticicestudio/nord-vim'
  use { 'norcalli/nvim-colorizer.lua', config = get_config('colorizer') }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

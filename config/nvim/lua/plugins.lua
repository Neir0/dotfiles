local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
	return string.format('require("config/%s")', name)
end

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- local plugins
	-- use({ "~/projects/neovim-plugins/glepnir-lspsaga.nvim", config = get_config("lspsaga") })
	-- use("~/projects/neovim-plugins/plenary.nvim")
	-- use({ "~/projects/neovim-plugins/telescope.nvim", config = get_config("telescope") })
	-- use("~/projects/neovim-plugins/ng.nvim")

	use("joeveiga/ng.nvim")
	use("nvim-lua/plenary.nvim")
	use({ "nvim-telescope/telescope.nvim", config = get_config("telescope") })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use({ "windwp/nvim-autopairs", config = get_config("autopairs") })
	use("kyazdani42/nvim-web-devicons")
	use({ "kyazdani42/nvim-tree.lua", config = get_config("nvim-tree") })
	use("tomtom/tcomment_vim")
	use("tpope/vim-fugitive")
	-- use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim", config = get_config("neogit") })
	use("tpope/vim-surround")
	use({ "phaazon/hop.nvim", config = get_config("hop") })
	use({ "kazhala/close-buffers.nvim", config = get_config("close-buffers") })
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons", opt = true },
			"arkav/lualine-lsp-progress",
		},
		config = get_config("lualine"),
	})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = get_config("treesitter") })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	-- use("shootex/nvim-treesitter-angular")
	use("windwp/nvim-ts-autotag")
	use({ "norcalli/nvim-colorizer.lua", config = get_config("colorizer") })
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		after = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = get_config("lspconfig"),
	})
	use({ "glepnir/lspsaga.nvim", branch = "main", config = get_config("lspsaga") })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		after = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = get_config("null-ls"),
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "onsails/lspkind.nvim" },
			-- { "hrsh7th/cmp-path" },
			-- { "hrsh7th/cmp-cmdline" },
			-- { "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "lukas-reineke/cmp-rg" } },
		},
		config = get_config("nvim-cmp"),
	})
	use("saadparwaiz1/cmp_luasnip")
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = get_config("luasnip"),
	})
	use({ "rmehri01/onenord.nvim", config = get_config("onenord") })
	-- use("arcticicestudio/nord-vim")
	use({
		"kkoomen/vim-doge",
		run = ":call doge#install()",
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

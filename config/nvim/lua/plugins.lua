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
	-- use("~/projects/neovim-plugins/plenary.nvim")
	-- use({ "~/projects/neovim-plugins/telescope.nvim", config = get_config("telescope") })
	use("~/projects/neovim-plugins/ng.nvim")
	use({
		-- "~/projects/neovim-plugins/lspsaga.nvim",
		"glepnir/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				code_action = {
					show_server_name = true,
					extend_gitsigns = false,
					keys = {
						quit = "<Esc>",
					},
				},
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					enable = false,
				},
				rename = {
					quit = "<Esc>",
				},
				-- ui = {
				-- 	kind = require("onenord.integrations.lspsaga").custom_kind(),
				-- },
			})
		end,
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- use("joeveiga/ng.nvim")
	use("nvim-lua/plenary.nvim")
	use({ "nvim-telescope/telescope.nvim", config = get_config("telescope") })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use({ "windwp/nvim-autopairs", config = get_config("autopairs") })
	use("kyazdani42/nvim-web-devicons")
	use({ "kyazdani42/nvim-tree.lua", config = get_config("nvim-tree") })
	-- use("tomtom/tcomment_vim")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
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
		"neovim/nvim-lspconfig",
		-- "~/projects/neovim-plugins/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
		config = get_config("lspconfig"),
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
		config = get_config("null-ls"),
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "onsails/lspkind.nvim" },
			-- { "hrsh7th/cmp-path" },
			-- { "hrsh7th/cmp-cmdline" },
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
	use({
		"aserowy/tmux.nvim",
		config = get_config("tmux"),
	})
	-- use({
	-- 	"rmehri01/onenord.nvim",
	-- 	config = get_config("onenord"),
	-- 	requires = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- })
	use({
		"Mofiqul/dracula.nvim",
		config = get_config("dracula"),
		requires = {
			"nvim-telescope/telescope.nvim",
		},
	})
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

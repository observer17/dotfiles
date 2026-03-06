-- install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	print("Installing " .. lazypath .. "..")
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
	spec = {
		-- themes
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{ "rose-pine/neovim", name = "rose-pine" },
		{
			"scottmckendry/cyberdream.nvim",
			lazy = false,
			priority = 1000,
		},
		{ "navarasu/onedark.nvim" },
		{ "bluz71/vim-moonfly-colors" },
		{ "Mofiqul/vscode.nvim" },
		{ "NTBBloodbath/sweetie.nvim" },
		{ "jascha030/nitepal.nvim" },
		{
			"lifepillar/vim-solarized8",
			branch = "neovim",
		},
		-- ui reletea
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lualine/lualine.nvim" },
		-- lsp & auto-complete
		{
			"williamboman/mason.nvim",
			dependencies = {
				"WhoIsSethDaniel/mason-tool-installer.nvim",
			},
		},
		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{ "L3MON4D3/LuaSnip" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "rafamadriz/friendly-snippets" },
			},
		},
		{ "hrsh7th/cmp-nvim-lsp" },
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		-- format
		{
			"nvimtools/none-ls.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		-- program language related
		{ "nvim-treesitter/nvim-treesitter" },
		-- search
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		-- file explorer
		{ "nvim-tree/nvim-tree.lua" },
		-- tools for dev
		{ "numToStr/Comment.nvim" },
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},
		{ "https://gn.googlesource.com/gn", rtp = "misc/vim" },
		-- sidekick (shell panel for CLI tools)
		{ "folke/sidekick.nvim" },
		-- lightweight floating terminal (Lua)
		{ "numToStr/FTerm.nvim" },
		-- AI Agent: CodeCompanion
		{
			"olimorris/codecompanion.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"j-hui/fidget.nvim",
			},
		},
		{ "j-hui/fidget.nvim" },
	},
	checker = { enable = true },
})

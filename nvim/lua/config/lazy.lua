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
		{ "williamboman/mason.nvim" },
		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
		{ "neovim/nvim-lspconfig" },
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{ "L3MON4D3/LuaSnip" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "rafamadriz/friendly-snippets" },
			},
		},
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "folke/neodev.nvim" },
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
		-- sidekick (shell panel)
		{ "folke/sidekick.nvim" },
		-- terminal integration
		{ "akinsho/toggleterm.nvim", version = "*" },
	},
	checker = { enable = true },
})

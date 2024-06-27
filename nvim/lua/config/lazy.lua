local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
print(lazypath)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	print("Installing " .. lazypath .. "..")
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{ "neovim/nvim-lspconfig" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
    { "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- file explorer
    { "nvim-tree/nvim-tree.lua" }
	},
--	install = { colorscheme = { "catppuccin" } },
	checker = { enable = true },
})
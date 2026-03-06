require("mason").setup({
	ui = {
		border = "rounded",
	},
})

-- Use mason-tool-installer to handle all tool & server installations
-- Names here must match Mason's registry (e.g., 'lua-language-server' not 'lua_ls')
require("mason-tool-installer").setup({
	ensure_installed = {
		"clangd",
		"rust-analyzer",
		"typescript-language-server",
		"pyright",
		"lua-language-server",
		"gn-language-server",
		"stylua",
		"clang-format",
	},
})

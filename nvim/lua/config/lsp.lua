local lspconfig = require("lspconfig")

local function show_diagnostic_float()
	-- for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
	--   if vim.api.nvim_win_get_config(winid).zindex then
	--     return
	--   end
	-- end

	vim.diagnostic.open_float({
		scope = "cursor",
		focusable = false,
		close_events = {
			"CursorMoved",
			"CursorMovedI",
			"BufHidden",
			"InsertCharPre",
			"WinLeave",
		},
	})
end

local function range_format()
	local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
	local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
	vim.lsp.buf.format({
		range = {
			["start"] = { start_row, 0 },
			["end"] = { end_row, 0 },
		},
		async = true,
	})

	local esc_key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc_key, "v", true)
end

local function on_attach(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gd", "<cmd> lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", opts)
	vim.keymap.set("n", "gr", "<cmd> lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd> lua vim.lsp.buf.implementation()<CR>", opts)

	-- keymap for format
	vim.keymap.set("n", "<Leader>f", "<cmd> lua vim.lsp.buf.format()<CR>", opts)
	vim.keymap.set("v", "<Leader>f", range_format, opts)
end

-- diagnostic related config  start ---
--
-- disable default virtual_text
vim.diagnostic.config({
	virtual_text = false,
})

-- setup lsp_line
require("lsp_lines").setup()

-- open float when hover
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = show_diagnostic_float,
})

--
-- diagnostic related config  end ---

-- ls for cpp using ccls
-- lspconfig.ccls.setup({
--   init_options = {
--     index = {
--       threads = 3
--     }
--   },
--   on_attach = on_attach,
-- })

-- ls for cpp using clangd
-- it seems like clangd is much more faster then ccls
lspconfig.clangd.setup({
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
	init_options = {
		index = {
			threads = 3,
		},
	},
	on_attach = on_attach,
})

local repo = require("utils.repo")

local function show_diagnostic_float()
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
	-- 在 AHA 仓库下不设置 LSP 的 <Leader>f，由 null-ls 模块进行覆盖
	if not repo.is_aha_repo() then
		vim.keymap.set("n", "<Leader>f", "<cmd> lua vim.lsp.buf.format()<CR>", opts)
		vim.keymap.set("v", "<Leader>f", range_format, opts)
	end
end

-- --- diagnostic configuration ---
vim.diagnostic.config({
	virtual_text = false,
})

require("lsp_lines").setup()

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = show_diagnostic_float,
})

-- --- Global LSP configuration (0.11+) ---
-- Apply on_attach to all servers
vim.lsp.config("*", {
	on_attach = on_attach,
})

-- --- Enable servers ---
-- Neovim will automatically load from lsp/*.lua
vim.lsp.enable({ "clangd", "rust_analyzer", "ts_ls", "pyright" })

-- Migrate away from nvim-lspconfig "framework" to native Neovim APIs
-- Uses vim.lsp.config + vim.lsp.start with autocommands per filetype

local repo = require("utils.repo")

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

-- 判断当前仓库是否为 AHA 仓库（用于快捷键覆盖策略）
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

-- Root finder helper
local function find_root(bufnr, markers)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local start = vim.fs.dirname(fname)
  local found = vim.fs.find(markers, { path = start, upward = true })[1]
  return found and vim.fs.dirname(found) or start
end

-- Autostart per filetype with dynamic root_dir
local grp = vim.api.nvim_create_augroup("UserLspAutoStart", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function(args)
    local root = find_root(args.buf, { "compile_commands.json", "compile_flags.txt", ".git" })
    vim.lsp.start({
      name = "clangd",
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
        "--log=verbose",
        "--query-driver=/usr/bin/clang,/opt/homebrew/opt/llvm/bin/clang",
      },
      init_options = { index = { threads = 3 } },
      on_attach = on_attach,
      root_dir = root,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = { "rust" },
  callback = function(args)
    local root = find_root(args.buf, { "Cargo.toml", "rust-project.json", ".git" })
    -- Prefer rustup-provided rust-analyzer to match proc-macro server version
    local rustup_ra = vim.fn.systemlist("rustup which rust-analyzer")[1]
    local ra_cmd = (rustup_ra and vim.fn.executable(rustup_ra) == 1) and { rustup_ra } or { "rust-analyzer" }
    vim.lsp.start({
      name = "rust_analyzer",
      cmd = ra_cmd,
      on_attach = on_attach,
      root_dir = root,
      settings = {
        ["rust-analyzer"] = {
          imports = { granularity = { group = "module" }, prefix = "self" },
          cargo = { buildScripts = { enable = false } },
          procMacro = { enable = false },
        },
      },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function(args)
    local root = find_root(args.buf, { "tsconfig.json", "jsconfig.json", "package.json", ".git" })
    vim.lsp.start({
      name = "ts_ls",
      cmd = { "typescript-language-server", "--stdio" },
      on_attach = on_attach,
      root_dir = root,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = { "python" },
  callback = function(args)
    local root = find_root(args.buf, { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" })
    vim.lsp.start({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      on_attach = on_attach,
      root_dir = root,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
    })
  end,
})

-- gn

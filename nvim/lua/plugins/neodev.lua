require("neodev").setup({})

local function on_attach(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gd", "<cmd> lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", opts)
	vim.keymap.set("n", "gr", "<cmd> lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd> lua vim.lsp.buf.implementation()<CR>", opts)

	vim.keymap.set("n", "<Leader>f", "<cmd> lua vim.lsp.buf.format()<CR>", opts)
end

local function find_root(bufnr, markers)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local start = vim.fs.dirname(fname)
  local found = vim.fs.find(markers, { path = start, upward = true })[1]
  return found and vim.fs.dirname(found) or start
end

local grp = vim.api.nvim_create_augroup("UserLuaLspAutoStart", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = { "lua" },
  callback = function(args)
    local root = find_root(args.buf, { ".luarc.json", ".luarc.lua", ".git" })
    vim.lsp.start({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      on_attach = on_attach,
      root_dir = root,
    })
  end,
})

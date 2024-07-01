local lspconfig = require('lspconfig')

local function on_attach(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gd", "<cmd> lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gr", "<cmd> lua vim.lsp.buf.references()<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd> lua vim.lsp.buf.implementation()<CR>", opts)
end

-- ls for cpp
lspconfig.ccls.setup({
  on_attach = on_attach,
})

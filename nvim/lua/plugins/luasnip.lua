local ls = require("luasnip")

ls.setup({

})

vim.opt.runtimepath = vim.opt.runtimepath + '~/.config/nvim/snippets'
-- require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets/ "})
require("luasnip.loaders.from_vscode").load()

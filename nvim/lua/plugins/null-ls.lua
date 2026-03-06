local null_ls = require("null-ls")
local repo = require("utils.repo")
local format = require("utils.format")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
	},
})

-- 在 LSP 附着后统一覆盖当前 buffer 的 <Leader>f
-- AHA 仓库：执行专用 clang-format.py；其他仓库：回退到 LSP 格式化
local grp = vim.api.nvim_create_augroup("UserNullLsFormatOverride", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = grp,
	callback = function(args)
		local bufnr = args.buf
		local opts = { buffer = bufnr, desc = "格式化当前文件" }
		vim.keymap.set("n", "<Leader>f", function()
			if repo.is_aha_repo() then
				repo.cc_format("%")
			else
				vim.lsp.buf.format()
			end
		end, opts)

		vim.keymap.set("v", "<Leader>f", function()
			if repo.is_aha_repo() then
				repo.cc_format("'<,'>")
			else
				format.range_format()
			end
		end, opts)
	end,
})

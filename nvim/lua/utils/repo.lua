local M = {}

function M.is_aha_repo()
	local origin = vim.fn.systemlist({ "git", "remote", "get-url", "origin" })[1] or ""
	-- 兼容多种 remote URL 格式（ssh/https），只要包含 lark/aha 即认为是目标仓库
	return origin:find("lark/aha") ~= nil
end

function M.cc_format(range)
	if not M.is_aha_repo() then
		return
	end
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if not git_root or git_root == "" then
		return
	end
	local format_py_path = git_root .. "/third_party/clang-format/script/clang-format.py"
	if vim.fn.filereadable(format_py_path) == 1 then
		range = range or ""
		vim.cmd(range .. "py3f " .. vim.fn.fnameescape(format_py_path))
	else
		print("Warning: clang-format.py not found at " .. format_py_path)
	end
end

return M

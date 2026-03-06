local cmd = vim.fn.stdpath("data") .. "/mason/bin/clangd"
if vim.fn.executable(cmd) ~= 1 then
	cmd = "clangd"
end

return {
	cmd = {
		cmd,
		"--offset-encoding=utf-16",
		"--query-driver=**",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
	init_options = { index = { threads = 3 } },
}

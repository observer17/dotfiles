return {
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
		"--log=verbose",
		"--query-driver=/usr/bin/clang,/opt/homebrew/opt/llvm/bin/clang",
	},
	root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
	init_options = { index = { threads = 3 } },
}

local rustup_ra = vim.fn.systemlist("rustup which rust-analyzer")[1]
local ra_cmd = (rustup_ra and vim.fn.executable(rustup_ra) == 1) and { rustup_ra } or { "rust-analyzer" }
return {
	cmd = ra_cmd,
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	settings = {
		["rust-analyzer"] = {
			linkedProjects = { "Cargo.toml" },
			imports = { granularity = { group = "module" }, prefix = "self" },
			cargo = { buildScripts = { enable = false } },
			procMacro = { enable = false },
		},
	},
}

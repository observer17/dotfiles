-- sidekick.nvim configuration
-- A floating/side panel for shell and other tools

require("sidekick").setup({
	-- Default settings
	defaults = {
		-- Panel position: left, right, top, bottom
		position = "right",
		-- Panel width (for left/right) or height (for top/bottom)
		size = 60,
		-- Show on startup
		open = false,
		-- Border style
		border = "rounded",
		-- Enter insert mode when opening
		enter = true,
	},

	-- Define custom panels
	panels = {
		-- Shell panel
		shell = {
			name = "Shell",
			filetype = "sidekick-shell",
			-- Spawn a shell when panel opens
			on_open = function(panel)
				vim.fn.termopen(vim.env.SHELL, {
					on_exit = function()
						-- Optional: close panel when shell exits
						-- vim.cmd("SidekickClose")
					end,
				})
			end,
		},
	},

  nes = {
    enable = false,
  },
  -- cli
  cli = {
    tools = {
      coco = {
        cmd = { "coco" },
        title = "Coco",
      }
    }
  }
})

-- Keymaps for sidekick
vim.keymap.set("n", "<leader>ts", "<cmd>Sidekick cli toggle<cr>", {
	desc = "Toggle sidekick panel",
})

-- Toggle shell specifically
vim.keymap.set("n", "<leader>sh", "<cmd>Sidekick toggle shell<cr>", {
	desc = "Toggle sidekick shell",
})

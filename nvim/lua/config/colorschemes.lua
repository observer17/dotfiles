vim.opt.termguicolors = true

-- set the colorscheme
-- local colorscheme = "catppuccin"
-- local colorscheme = "rose-pine"
local colorscheme = "moonfly"

-- require("themes." .. colorscheme)

-- setup must be called before loading
vim.cmd.colorscheme(colorscheme)

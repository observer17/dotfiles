-- ToggleTerm 配置
local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.35
    else
      return 20
    end
  end,
  open_mapping = [[<C-`>]],
  shade_terminals = true,
  start_in_insert = true,
  persist_size = true,
  persist_mode = true,
  direction = "float",
  float_opts = {
    border = "rounded",
    winblend = 0,
  },
  shell = vim.o.shell,
})

-- 快捷键：浮窗/水平/垂直终端切换
vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "切换浮窗终端" })
vim.keymap.set({ "n", "t" }, "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<CR>", { desc = "切换水平终端" })
vim.keymap.set({ "n", "t" }, "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "切换垂直终端" })

-- LazyGit 集成（若系统安装了 lazygit）
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
vim.keymap.set("n", "<leader>gg", function()
  lazygit:toggle()
end, { desc = "打开 LazyGit" })


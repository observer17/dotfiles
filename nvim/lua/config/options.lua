-- **************** --
--  Tab 
-- **************** --

-- 将制表符扩展为空格
vim.opt.expandtab = true
-- 设置编辑时制表符占用空格数
vim.opt.tabstop = 2
-- 将连续数量的空格视为一个制表符
vim.opt.softtabstop = 2
-- 设置格式化时制表符占用空格数
vim.opt.shiftwidth = 2


-- **************** --
-- UI
-- **************** --

-- 显示行号
vim.opt.number = true

-- 显示相对行号
vim.opt.relativenumber = true

-- 高亮当前行/列
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.termguicolors = true


-- Search
vim.opt.hlsearch = true

-- lsp
vim.lsp.set_log_level("off")

-- FS settings to avoid conflicts with file watchers (like rust-analyzer) on macOS
vim.opt.backupcopy = "yes"
vim.opt.writebackup = false

-- **************** --
-- Shell（macOS 推荐设置）
-- **************** --

do
  local homebrew_zsh = "/opt/homebrew/bin/zsh"
  if vim.fn.executable(homebrew_zsh) == 1 then
    vim.opt.shell = homebrew_zsh
  else
    vim.opt.shell = vim.env.SHELL or "/bin/zsh"
  end
  -- 让 :terminal 和 :! 命令以登录方式加载环境（PATH 等）
  vim.opt.shellcmdflag = "-lc"
  -- 让 Git 使用 Neovim 作为编辑器
  vim.env.GIT_EDITOR = "nvim"
end

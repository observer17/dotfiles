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

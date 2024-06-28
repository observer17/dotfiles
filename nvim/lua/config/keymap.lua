-- map leader
vim.g.mapleader = vim.keycode";"
-- vim.g.maplocalleader = "\\"

-- Switching Panes
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")

-- 快速打开 init.lua 文件
vim.keymap.set("n", "<Leader>v", "<cmd> vs $MYVIMRC<CR>")
-- :luafile $MYVIMRC

-- reload init.lua 文件
vim.keymap.set("n", "<Leader>sv", "<cmd> luafile $MYVIMRC<CR>")

-- 快速输入命令
vim.keymap.set("n", "<space>", ":")

-- 切换buffer
vim.keymap.set("n", "<C-B>", "<cmd> bp<CR>")
vim.keymap.set("n", "<C-F>", "<cmd> bn<CR>")

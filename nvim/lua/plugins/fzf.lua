-- helper function
function contextual_fzf() 
  vim.cmd("!git rev-parse --show-toplevel", { silent = true })
  vim.cmd("FzfLua files")
end

-- set keymap
vim.keymap.set("n", "<C-p>", contextual_fzf, { silent = true })

require("fzf-lua").setup({
})

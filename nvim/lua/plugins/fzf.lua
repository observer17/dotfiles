-- helper function
function contextual_fzf() 
  local is_git = vim.cmd("!git rev-parse --show-toplevel", { silent = true })
  if is_git then
    vim.cmd("FzfLua git_files")
  else 
    vim.cmd("FzfLua files")
  end
end

-- set keymap
vim.keymap.set("n", "<C-p>", contextual_fzf, { silent = true })

require("fzf-lua").setup({
})

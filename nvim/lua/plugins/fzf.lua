-- helper function
local function contextual_fzf()
  local is_git = vim.cmd("!git rev-parse --show-toplevel", { silent = true })
  if is_git then
    vim.cmd("FzfLua git_files")
  else
    vim.cmd("FzfLua files")
  end
end

-- set keymap
vim.keymap.set("n", "<C-p>", contextual_fzf, { silent = true })
vim.keymap.set("n", "<Leader>ff", "<cmd> FzfLua<CR>", { silent = true })

require("fzf-lua").setup({
  -- disable git_icon cause it slows in large repo
  files                = {
    git_icons              = false,
  },
  git = {
    files = {
      git_icons         = false,
    },
  },
})

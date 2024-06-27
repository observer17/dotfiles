local function tree_on_attach(bufnr) 
  local api = require("nvim-tree.api")

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- del conflict keymappings first
  -- vim.keymap.del("n", "s")

  vim.keymap.set("n", "<Leader>fe", "<cmd> NvimTreeToggle<CR>", { silent = true })
  vim.keymap.set("n", "i", api.node.open.horizontal, { buffer = true, silent = true })
  vim.keymap.set("n", "s", api.node.open.vertical, { buffer = true, silent = true })
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    adaptive_size = true,
  },
  renderer = {
    icons = {
      show = {
        git = false,
        file = false,
        folder = false,
        folder_arrow = true,
      },
      glyphs = {
        folder = {
          arrow_closed = "⏵",
          arrow_open = "⏷",
        },
      },
    },
    group_empty = true
  },
  filters = {
    dotfiles = true
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      },
    },
  },
  on_attach = tree_on_attach,
})

local cmp = require("cmp")

-- util funtion
function select_next_item(fallback) 
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(select_next_item, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  -- formatting = {
  -- fields = { "abbr", "menu" },
  -- },
})

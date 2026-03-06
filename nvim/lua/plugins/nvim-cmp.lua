local cmp = require("cmp")
local luasnip = require("luasnip")

-- util funtion
local function select_next_item(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local function select_prev_item(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "lazydev", group_index = 0 },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(select_next_item, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(select_prev_item, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  -- formatting = {
  -- fields = { "abbr", "menu" },
  -- },
})

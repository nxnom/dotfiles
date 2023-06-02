-- -@diagnostic disable: need-check-nil
local status, cmp = pcall(require, "cmp")
if (not status) then return end

local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

-- luasnip.config.set_config({
--   history = true,
--   updateevents = "TextChanged,TextChangedI",
--   enable_autosnippets = true,
-- })

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's', 'c' })
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip', max_item_count = 5 },
    -- I hate this source, so annoying
    -- { name = 'buffer',  max_item_count = 2 },
  }),
  formatting = {
    -- format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    -- ghost_text = true
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

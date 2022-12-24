vim.g.copilot_filetypes = {
  ["*"] = false,
  lua = true,
  html = true,
  css = true,
  javascript = true,
  typescript = true,
  dart = true,
  ruby = true,
}

vim.keymap.set('n', '<C-\\>', ':Copilot panel<Return>', { silent = true })

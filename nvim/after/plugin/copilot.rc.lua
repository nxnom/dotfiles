vim.g.copilot_filetypes = {
  ["*"] = true,
  -- ["*"] = false,
  -- rust = true,
  -- lua = true,
  -- html = true,
  -- css = true,
  -- javascript = true,
  -- typescript = true,
  -- dart = true,
  -- ruby = true,
  -- zsh = true,
  -- vue = true,
}

vim.keymap.set('n', '<C-\\>', ':Copilot panel<Return>', { silent = true })
vim.keymap.set('n', '<leader>cd', ':Copilot disable<Return>', { silent = true })
vim.keymap.set('n', '<leader>ce', ':Copilot enable<Return>', { silent = true })

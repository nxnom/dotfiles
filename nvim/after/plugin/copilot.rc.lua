vim.g.copilot_filetypes = {
  ["*"] = true,
  -- ["*"] = false,
  -- rust = true,
}

vim.keymap.set('n', '<C-\\>', ':Copilot panel<Return>', { silent = true })
vim.keymap.set('n', '<leader>cd', ':Copilot disable<Return>', { silent = true })
vim.keymap.set('n', '<leader>ce', ':Copilot enable<Return>', { silent = true })

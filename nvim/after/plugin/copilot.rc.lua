-- For more info run :help copilot
vim.g.copilot_filetypes = { xml = false }

-- vim.g.copilot_filetypes = { ["*"] = false, xml = true }

vim.keymap.set('n', '<C-\\>', ':Copilot panel<Return>', { silent = true })

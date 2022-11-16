local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.init_lsp_saga {
  finder_request_timeout = 8000,
  server_filetype_map = {
    typescript = 'typescript'
  }
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>er', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<Leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<Leader>tt', '<Cmd>Lspsaga open_floaterm<CR>', opts)
vim.keymap.set('t', '<C-t>', '<Cmd>Lspsaga close_floaterm<CR>', opts)

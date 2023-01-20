local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {
  finder_request_timeout = 8000,
  rename_in_select = false,
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = -1,
    virtual_text = true,
  },
  ui = {
    title = true,
    border = 'single',
    winblend = 0,
    colors = {
      normal_bg = '#1c1c19',
    }
  }
  -- server_filetype_map = {
  --   typescript = 'typescript'
  -- }
}

-- noremap = true,
local opts = { silent = true }
vim.keymap.set('n', '<Leader>er', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<Leader>eu', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<Leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '""', '<Cmd>Lspsaga term_toggle<CR>', opts)
vim.keymap.set('t', '""', '<Cmd>Lspsaga term_toggle<CR>', opts)

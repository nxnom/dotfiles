local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {
  ui = {
    kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    border = 'single',
    winblend = 0,
    colors = {
      normal_bg = '#1c1c19',
    }
  },
  request_timeout = 8000,
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = -1,
    -- virtual_text = true,
  },
  symbol_in_winbar = {
    enable = false,
  },
  finder = {
    keys = {
      expand_or_jump = '<CR>',
    },
  },
  outline = {
    win_position = 'right',
    win_with = '',
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = 'o',
      expand_collapse = 'u',
      quit = 'q',
    },
  },
  rename = {
    quit = '<C-c>',
    exec = '<CR>',
    mark = 'x',
    confirm = '<CR>',
    in_select = true,
    whole_project = true,
  },
}

-- noremap = true,
local opts = { silent = true }
vim.keymap.set('n', '<Leader>er', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<Leader>eu', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gt', '<Cmd>Lspsaga goto_definition<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<Leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<Leader>lo', '<Cmd>Lspsaga outline<CR>', opts)
vim.keymap.set('n', '""', '<Cmd>Lspsaga term_toggle<CR>', opts)
vim.keymap.set('t', '""', '<Cmd>Lspsaga term_toggle<CR>', opts)

local status, saga = pcall(require, "lspsaga")
if (not status) then return end

local api, util = vim.api, vim.lsp.util

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
    enable = false,
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

-- If there are multiple LSP servers attached to the current buffer, this function
-- will display the hover information from all of them.
-- Lspsaga only displays the hover information from the first LSP server.
local custom_hover = function()
  local filetype = vim.bo.filetype
  local multi_lsp_files = { 'ruby' }

  local hover = require('lspsaga.hover')

  if vim.tbl_contains(multi_lsp_files, filetype) ~= true then
    vim.cmd('Lspsaga hover_doc')
    -- this line is require to reset the pending_request or it won't work after hovering single/zero lsp server
    hover.pending_request = false
    return
  end


  if hover.preview_winid and api.nvim_win_is_valid(hover.preview_winid) then
    api.nvim_set_current_win(hover.preview_winid)
    return
  end

  if vim.bo.filetype == 'help' then
    api.nvim_feedkeys('K', 'ni', true)
    return
  end

  if hover.pending_request then
    print('[Multi_lsp_hover] There is already a hover request, please wait for the response.')
    return
  end

  hover.pending_request = true

  local params = util.make_position_params()
  local clients = vim.lsp.get_active_clients({ buffer = 0 })

  vim.lsp.buf_request_all(0, 'textDocument/hover', params, function(response)
    local value = ''
    hover.pending_request = false

    for i = 1, #response do
      if response[i] and response[i].result and response[i].result.contents then
        local content = response[i].result.contents.value
        if not content then return end
        if not clients[i] then return end

        local name = clients[i].name

        -- Add a separator between hover information from different LSP servers if there are more than one.
        if name and #response > 1 then
          value = value .. '\n   \n------------------------------\n'
          value = '\n' .. value .. '\n    *** ' .. name .. ' ***\n'
          value = value .. '------------------------------\n'
        end

        value = value .. content .. '  '
      end
    end

    if value == '' then
      print('No hover available')
      return
    end

    local res = { value = value, kind = 'markdown' }
    hover:open_floating_preview(res)
  end)
end

-- noremap = true,
local opts = { silent = true }
vim.keymap.set('n', '<Leader>er', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<Leader>eu', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'K', custom_hover, opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>', opts)
vim.keymap.set('n', 'fd', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<Leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<Leader>lo', '<Cmd>Lspsaga outline<CR>', opts)
vim.keymap.set('n', '""', '<Cmd>Lspsaga term_toggle<CR>', opts)
vim.keymap.set('t', '""', '<Cmd>Lspsaga term_toggle<CR>', opts)

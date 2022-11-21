local keymap = vim.keymap

-- Do not yank with x
keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a world backwords
-- keymap.set('n', 'dw', 'vb"_d')

-- Select all
-- keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'st', ':tabedit<Return>', { silent = true })

-- Split windows
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })

-- keymap.set('n', '<Leader>1', ':vertical resize +5<Return>', { silent = true })
-- keymap.set('n', '<Leader>2', ':vertical resize -5<Return>', { silent = true })

-- Move windor
keymap.set('n', '<Leader>n', '<C-w>w')

keymap.set('v', '<C-s>', function()
  local starting, ending = vim.api.nvim_buf_get_mark(0, "<")[1] - 1, vim.api.nvim_buf_get_mark(0, ">")[1]
  vim.api.nvim_command('nohls')

  print(starting, ending)
  local textCode = table.concat(vim.api.nvim_buf_get_lines(0, starting, ending, false), "\n")

  print(textCode)
  -- local filetype = vim.bo.filetype
  -- local response = io.popen("silicon --from-clipboard --output ~/Screenshot/Silicon/$(date +%Y%m%d%H%M%S).png -l " ..
  --   filetype)
  --
  -- if (response == nil) then
  --   print('Screenshot success')
  --   return
  -- end
  --
  -- local result = response:read("*a")
  -- response:close()
  -- print(result)

end)

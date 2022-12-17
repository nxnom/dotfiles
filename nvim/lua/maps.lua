local keymap = vim.keymap

-- Do not yank
keymap.set('n', 'x', '"_x')
keymap.set('n', 'c', '"_c')

-- Vertical Movement with center
keymap.set('n', '<C-u>', "<C-u>zz")
keymap.set('n', '<C-d>', "<C-d>zz")

keymap.set('n', 'n', "nzzzv")
keymap.set('n', 'N', "nzzzv")

keymap.set('n', 'J', "mzJ`z") -- restore cursor location

-- clipboards
keymap.set('n', 'Y', "y$") -- copy from cursor to end of line
keymap.set('n', '<Leader>y', '"+y')
keymap.set('n', '<Leader>Y', '"+y$') -- copy from cursor to end of line
keymap.set('v', '<Leader>y', '"+y')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- New tab
keymap.set('n', '<Leader>st', ':tabedit<Return>', { silent = true })

-- Split windows
keymap.set('n', '<Leader>ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', '<Leader>sv', ':vsplit<Return><C-w>w', { silent = true })

keymap.set('n', '<Leader>sm', ':vsplit<Return><C-w>w:vertical resize 60<Return>:set nornu<Return>:set nonu<Return>',
  { silent = true })

-- Move window
keymap.set('n', '<Leader>n', '<C-w>w')

-- Move line
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

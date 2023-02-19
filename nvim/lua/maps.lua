local keymap = vim.keymap

keymap.set('n', '<Leader>o', 'o<Esc>', { noremap = true })
keymap.set('n', '<Leader>O', 'mzO<Esc>`z', { noremap = true })

-- Do not yank
keymap.set('n', 'x', '"_x', { noremap = true })
keymap.set('n', 'c', '"_c', { noremap = true })

-- Vertical Movement with center
keymap.set('n', '<C-u>', "<C-u>zz", { noremap = true })
keymap.set('n', '<C-d>', "<C-d>zz", { noremap = true })

keymap.set('n', 'n', "nzzzv", { noremap = true })
keymap.set('n', 'N', "nzzzv", { noremap = true })

keymap.set('n', 'J', "mzJ`z", { noremap = true }) -- restore cursor location

-- clipboards
keymap.set('n', 'Y', "y$", { noremap = true }) -- copy from cursor to end of line
keymap.set('n', '<Leader>y', '"+y', { noremap = true })
keymap.set('n', '<Leader>Y', '"+y$', { noremap = true }) -- copy from cursor to end of line
keymap.set('v', '<Leader>y', '"+y', { noremap = true })

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

-- Resize windows
keymap.set('n', '<C-Up>', ':resize -2<Return>', { silent = true })
keymap.set('n', '<C-Down>', ':resize +2<Return>', { silent = true })
keymap.set('n', '<C-Left>', ':vertical resize -2<Return>', { silent = true })
keymap.set('n', '<C-Right>', ':vertical resize +2<Return>', { silent = true })

-- Move window
keymap.set('n', '<Leader>n', '<C-w>w')

-- Move line
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Insert keymap
keymap.set('i', '<C-e>', '<Esc>A;<Return>', { noremap = true });

-- Codi keymap
keymap.set('n', '<Leader>xx', ':Codi<Return>', { silent = true })
keymap.set('n', '<Leader>zz', ':Codi!<Return>', { silent = true })

-- Move select word between '' or "" or () or [] or {}
keymap.set('n', "<Leader>''", "diwi''<Esc>hp", { noremap = true })
keymap.set('n', '<Leader>""', 'diwi""<Esc>hp', { noremap = true })
keymap.set('n', '<Leader>((', 'diwi()<Esc>hp', { noremap = true })
keymap.set('n', '<Leader>[[', 'diwi[]<Esc>hp', { noremap = true })
keymap.set('n', '<Leader>{{', 'diwi{}<Esc>hp', { noremap = true })

-- Move visual selected values between '' or "" or () or [] or {}
-- Not Working for Visual Line
keymap.set('v', "<Leader>''", "di''<Esc>hp", { noremap = true })
keymap.set('v', '<Leader>""', 'di""<Esc>hp', { noremap = true })
keymap.set('v', '<Leader>((', 'di()<Esc>hp', { noremap = true })
keymap.set('v', '<Leader>[[', 'di[]<Esc>hp', { noremap = true })
keymap.set('v', '<Leader>{{', 'di{}<Esc>hp', { noremap = true })

-- LSP
keymap.set('n', '<Leader>fo', vim.lsp.buf.format)

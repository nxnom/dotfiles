local status, ufo = pcall(require, 'ufo')

if not status then return end

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable = true

-- vim.keymap.set('n', '<Leader>zO', require('ufo').openAllFolds)
-- vim.keymap.set('n', '<Leader>zM', require('ufo').closeAllFolds)

ufo.setup({
  close_fold_kinds = { 'imports', 'comment' },
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
});

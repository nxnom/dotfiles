local is_exit, git_conflict = pcall(require, 'git-conflict')

if not is_exit then return end

git_conflict.setup({
  default_mappings = false,
})

vim.keymap.set('n', '<Leader>ac', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', '<Leader>ai', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', '<Leader>ab', '<Plug>(git-conflict-both)')
vim.keymap.set('n', '<Leader>an', '<Plug>(git-conflict-none)')
vim.keymap.set('n', '<Leader>gcp', '<Plug>(git-conflict-prev-conflict)')
vim.keymap.set('n', '<Leader>gcn', '<Plug>(git-conflict-next-conflict)')

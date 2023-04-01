local status = pcall(require, "catppuccin")
if (not status) then return end

vim.cmd [[colorscheme catppuccin-macchiato]]

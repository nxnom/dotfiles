local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup()

lspconfig.setup {
  ensure_installed = {
    'lua_ls',
    'html',
    'cssls',
    'emmet_ls',
    'tailwindcss',
    'tsserver',
    'rust_analyzer',
    'volar',      -- vue-lsp
    'solargraph', -- ruby-lsp
    'sorbet',     -- ruby-lsp
    -- 'eslint_d',
    -- 'prettierd',
    -- 'sqls',
    -- 'buf',
    -- 'protolint',
  },
}

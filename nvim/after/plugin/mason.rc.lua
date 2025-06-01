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
    'ts_ls',
    'rust_analyzer',
    'eslint',
    -- 'volar',      -- vue-lsp
    -- 'solargraph', -- ruby-lsp
    -- 'sorbet',     -- ruby-lsp
    'pyright',
    -- 'eslint_d',
    -- 'prettierd',
    -- 'sqls',
    -- 'buf',
    -- 'protolint',
  },
}

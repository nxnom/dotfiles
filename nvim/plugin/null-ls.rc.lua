local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local d = null_ls.builtins.diagnostics
local f = null_ls.builtins.formatting
local c = null_ls.builtins.code_actions

-- Docs
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc
-- https://docs.rockylinux.org/books/nvchad/custom/plugins/null_ls/#
null_ls.setup {
  sources = {
    f.prettierd.with({
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/configs/.prettierrc.js"),
      },
    }),
    d.eslint_d.with({
      diagnostics_format = '[eslint_d] #{m}\n(#{c})'
    }),
    c.eslint_d,
    d.tidy.with({
      diagnostics_format = '[tidy] #{m}\n(#{c})',
      args = { "--drop-empty-elements", "no", "--warn-proprietary-attributes", "no" },
    }), -- to diagnostics html
    d.protolint,
    f.protolint,
    -- null_ls.builtins.hover.dictionary
    -- python
    d.ruff,
    f.black
  },
}


vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)

local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- Docs
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc
-- https://docs.rockylinux.org/books/nvchad/custom/plugins/null_ls/#
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd.with({
      -- just put prettier config in home dir -_- I don't know why this is not working either
      -- env = {
      --   PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
      -- },
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint_d] #{m}\n(#{c})'
    }),
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.tidy.with({
      diagnostics_format = '[tidy] #{m}\n(#{c})',
      args = { "--drop-empty-elements", "no", "--warn-proprietary-attributes", "no" },
    }), -- to diagnostics html
    -- null_ls.builtins.hover.dictionary
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end
}

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

-- after the language server attaches to the current buffer
-- local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

-- local auto_format = function(_, bufnr)
--   vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
--   vim.api.nvim_create_autocmd("BufWritePre", {
--     group = augroup_format,
--     buffer = bufnr,
--     callback = function()
--       vim.lsp.buf.format({ bufnr = bufnr })
--     end,
--   })
-- end

-- local format = function(_, bufnr)
--   vim.keymap.set('n', '<Leader>fo', function()
--     vim.lsp.buf.format({ bufnr = bufnr })
--   end)
-- end

local disable_format = function(client)
  client.server_capabilities.document_formatting = false
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- https://flow.org/en/docs/install/
-- nvim_lsp.flow.setup {
--   capabilities = capabilities
-- }

nvim_lsp.tsserver.setup {
  init_options = {
    preferences = { disableSuggestions = true },
  },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  on_attach = disable_format,
  single_file_support = true,
}

nvim_lsp.lua_ls.setup {
  -- on_attach = format,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

nvim_lsp.html.setup {
  capabilities = capabilities,
  on_attach = disable_format,
}

nvim_lsp.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  }
})

-- css
nvim_lsp.cssls.setup {
  capabilities = capabilities,
  on_attach = disable_format,
}

nvim_lsp.tailwindcss.setup {
  autostart = false;
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

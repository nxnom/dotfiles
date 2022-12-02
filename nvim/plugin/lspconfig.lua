--vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

-- after the language server attaches to the current buffer
local auto_format = function(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
  end
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
    preferences = {
      disableSuggestions = true,
    },
  },
  -- filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = nvim_lsp.util.root_pattern("index.html", "index.js", "package.json", "tsconfig.json", "jsconfig.json",
    ".git"),
  capabilities = capabilities
}

-- for swift and c-based languages
-- nvim_lsp.sourcekit.setup {
--   on_attach = auto_format,
-- }

nvim_lsp.sumneko_lua.setup {
  on_attach = auto_format,
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
  capabilities = capabilities
}

-- css lsp server
nvim_lsp.cssls.setup {
  on_attach = auto_format,
  capabilities = capabilities
}
-- nvim_lsp.tailwindcss.setup {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
}
)

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

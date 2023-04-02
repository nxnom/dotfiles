-- https://neovim.io/doc/user/lsp.html
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local HOME = os.getenv('HOME')

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

vim.lsp.set_log_level("error")

local util = require 'lspconfig.util'

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

nvim_lsp.lua_ls.setup {
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

nvim_lsp.tsserver.setup {
  init_options = {
    preferences = { disableSuggestions = true },
  },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  single_file_support = true,
}

local function get_typescript_server_path(root_dir)
  local found_ts = ''
  local function check_dir(path)
    found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    local global_ts = vim.fn.system("echo -n $TYPESCRIPT_PATH")
    if (global_ts == '') then
      vim.notify(
        'Could not find typescript folder. Please set $TYPESCRIPT_PATH to the location of the typescript folder or install typescript in project locally. Typescript is required to enable vue-language-server.',
        vim.log.levels.WARN
      )
    end
    return util.path.join(global_ts, 'lib')
  end
end

-- Vue.js
nvim_lsp.volar.setup {
  capabilities = capabilities,
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
}

nvim_lsp.emmet_ls.setup({
  filetypes = { 'html', 'react', 'typescriptreact', 'javascriptreact', 'vue', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
  autostart = false,
})

-- Ruby
-- I use solargraph mainly for formatting and linting
nvim_lsp.solargraph.setup {
  init_options = {
    hover = true,
    references = false,
    rename = false,
    definitions = false,
    completion = false,
  }
}

-- Sorbet is better than solargraph for autocompletion and lsp support
nvim_lsp.sorbet.setup {
  on_new_config = function(new_config, root_dir)
    local cmd = { "srb", "tc", "--lsp", "--disable-watchman", "--typed=true" }

    local path = util.path.join(root_dir, 'sorbet')
    if util.path.exists(path) == false then
      -- fallback to default sorbet path
      -- Install sorbet locally for more intellisense and auto completion
      -- fallback is just for stdlib
      table.insert(cmd, "--dir=" .. util.path.join(HOME, ".config", "nvim", "configs", "sorbet"))
    end
    new_config.cmd = cmd
  end
}
-- End Ruby

-- DBMS
-- Unfortunately, sqls is not maintained anymore
-- But work better than other lsp servers for sql -_-
-- Check this link to see how to setup sqls
-- https://github.com/lighttiger2505/sqls
nvim_lsp.sqls.setup {
  on_attach = function(client, bufnr)
    -- https://github.com/nanotee/sqls.nvim
    require('sqls').on_attach(client, bufnr)
  end
}
-- End DBMS

nvim_lsp.html.setup { capabilities = capabilities }
-- css
nvim_lsp.cssls.setup { capabilities = capabilities }
nvim_lsp.tailwindcss.setup { autostart = false }

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

-- Keymaps
vim.keymap.set('n', '<Leader>fm', function()
  vim.lsp.buf.format()
end)

local status, flutter = pcall(require, "flutter-tools")
if (not status) then return end

flutter.setup {
  ui = {
    border = "rounded",
    notification_style = 'native'
  },
  decorations = {
    statusline = {
      app_version = false,
      device = false,
    }
  },
  -- debugger = { -- integrate with nvim dap + install dart code debugger
  --   enabled = false,
  --   run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
  --   exception_breakpoints = {}
  --   register_configurations = function(paths)
  --     require("dap").configurations.dart = {
  --     }
  --   end,
  -- },
  flutter_path = "/usr/local/bin/flutter", -- <-- this takes priority over the lookup
  flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  widget_guides = {
    enabled = false,
  },
  closing_tags = {
    prefix = " -- ", -- character to use for close tag e.g. > Widget
    enabled = true -- set to false to disable
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  dev_tools = {
    autostart = false, -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    -- analysisExcludedFolders = {"<path-to-flutter-sdk-packages>"},
    on_attach = function(client)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
      end
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      renameFilesWithClasses = "prompt", -- "always"
      enableSnippets = true,
    }
  }
}

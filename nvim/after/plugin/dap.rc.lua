local status, dap = pcall(require, "dap")
if (not status) then
  print('dap not found')
  return
end

dap.set_log_level('ERROR'); -- TRACE DEBUG INFO WARN ERROR
dap.defaults.fallback.terminal_win_cmd = 'rightb vs new'

local repl = require 'dap.repl'

repl.commands = vim.tbl_extend('force', repl.commands, {
  clear = { 'clear', '.clear', 'cls', 'c' },
})

vim.fn.sign_define('DapBreakpoint', { text = '🔹', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔻', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '✅', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = '', linehl = '', numhl = '' })

local debugJSInChrome = function()
  local port = vim.fn.input('Port: ')
  if (port == '') then return end

  dap.run({
    type = "chrome",
    request = "launch",
    name = "Debug WebApp in Chrome",
    url = "http://localhost:" .. port,
    webRoot = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    cwd = vim.fn.getcwd(),
    protocol = "inspector",
  })
end

-- Key maps
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dr', function()
  dap.run_last();
  vim.cmd('stopinsert') -- somehow [dap.run_last] change into insert mode
end)
vim.keymap.set('n', '<leader>djc', debugJSInChrome)
vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>do', dap.step_out)
vim.keymap.set('n', '<leader>dn', dap.step_over)
vim.keymap.set('n', '<leader>dp', function()
  dap.repl.toggle(nil, "rightb vs")
  -- vim.cmd [[wincmd p]] -- focus to the REPL
end)

vim.keymap.set('n', '<leader>dq', dap.close)
vim.keymap.set('n', '<leader>dd', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dC', dap.clear_breakpoints)
vim.keymap.set('n', '<leader>db', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.keymap.set('n', '<leader>dl', function()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)

dap.adapters.flutter = {
  type = "executable",
  command = "dart-debug-adapter",
  args = { "flutter" }
}

dap.adapters.chrome = {
  type = "executable",
  command = "chrome-debug-adapter",
  -- change to your debug adapter folder: this is packer run path
  -- args = { os.getenv("HOME") .. "/.local/share/nvim/site/pack/packer/opt/vscode-chrome-debug/out/src/chromeDebug.js" }
}

require("dap-vscode-js").setup({
  debugger_cmd = { "js-debug-adapter" },
  adapters = {
    "pwa-node",
    "pwa-chrome",
    "pwa-msedge",
    "node-terminal",
    "pwa-extensionHost",
  }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  dap.configurations[language] = {
    {
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
      console = 'integratedTerminal',
    },
    {
      name = "Run 'npm run dev'",
      request = "launch",
      runtimeArgs = { "run", "dev" },
      cwd = "${workspaceFolder}",
      runtimeExecutable = "npm",
      skipFiles = { "<node_internals>/**" },
      console = "integratedTerminal",
      type = "pwa-node",
      restart = true,
    },
    {
      name = "Attach",
      type = "pwa-node",
      request = "attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      name = "Debug Jest Tests",
      type = "pwa-node",
      request = "launch",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end

local present, dapui = pcall(require, "dapui")
if not present then
  print("dapui not found")
  return
end

dapui.setup({
  layouts = {
    {
      elements = {
        -- "repl",
        "console"
      },
      size = 0.4, -- 25% of total lines
      position = "right",
    },
  },
})

-- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
-- dap.listeners.before.event_exited["dapui_config"] = dapui.close
-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close -- trigger when event end

vim.keymap.set('n', '<leader>du', dapui.toggle)
vim.keymap.set('n', '<leader>dk', function()
  dapui.eval(nil, { enter = true })
end)
vim.keymap.set('n', '<leader>dU', function()
  dapui.float_element('Float', { enter = true })
end)
vim.keymap.set('n', '<leader>df', function()
  dapui.float_element('Scopes', { enter = true })
end)

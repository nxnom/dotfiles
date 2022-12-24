local status, dap = pcall(require, "dap")
if (not status) then print('dap not found') return end

dap.set_log_level('ERROR'); -- TRACE DEBUG INFO WARN ERROR
dap.defaults.fallback.terminal_win_cmd = 'rightb vs new'
-- dap.defaults.fallback.focus_terminal = true

vim.fn.sign_define('DapBreakpoint', { text = '🔹', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔻', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '✅', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = '', linehl = '', numhl = '' })


vim.keymap.set('n', '<leader>dc', dap.continue)

vim.keymap.set('n', '<leader>djc', function()
  local port = vim.fn.input('Port: ')

  dap.run({
    type = "chrome",
    request = "launch",
    name = "Debug vite app",
    url = "http://localhost:" .. port,
    webRoot = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    cwd = vim.fn.getcwd(),
    protocol = "inspector",
  })
end)

vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>do', dap.step_out)
vim.keymap.set('n', '<leader>dn', dap.step_over)
vim.keymap.set('n', '<leader>dr', function()
  dap.repl.toggle(nil, "rightb vs")
  -- focus to the REPL
  -- vim.cmd [[wincmd p]]
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

dap.terminate(nil, nil, function() end)

require("dap-vscode-js").setup({
  log_file_level = vim.log.levels.TRACE,
  adapters = {
    "pwa-node",
    "pwa-chrome",
    "pwa-msedge",
    "node-terminal",
    "pwa-extensionHost",
  }, -- which adapters to register in nvim-dap
})

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/Debuggers/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      console = 'integratedTerminal',
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
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
    {
      name = "npm run dev",
      request = "launch",
      runtimeArgs = { "run", "dev" },
      cwd = "${workspaceFolder}",
      runtimeExecutable = "npm",
      skipFiles = { "<node_internals>/**" },
      console = "integratedTerminal",
      type = "pwa-node",
      restart = true,
    },
  }
end

local present, dapui = pcall(require, "dapui")
if not present then print("dapui not found") return end

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

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close({})
-- end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

vim.keymap.set('n', '<leader>du', function()
  ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
  require("dapui").toggle()
end)
vim.keymap.set('n', '<leader>dk', function()
  ---@diagnostic disable-next-line: param-type-mismatch
  dapui.eval(nil, { enter = true })
end)
vim.keymap.set('n', '<Leader>df', function()
  dapui.float_element('Scopes', { enter = true })
end)

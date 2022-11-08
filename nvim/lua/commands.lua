local keymap = vim.keymap

vim.api.nvim_create_user_command('Silicon', function()
  local filetype = vim.bo.filetype
  local f = assert(io.popen("silicon --from-clipboard --output ~/Screenshot/Silicon/$(date +%Y%m%d%H%M%S).png -l " ..
    filetype, "r"))

  local s = assert(f:read("*a"))
  f:close()

  if (s == '') then
    vim.api.nvim_notify('Screenshot success', vim.log.levels.INFO, {})
    return
  end

  vim.api.nvim_notify(s, vim.log.levels.INFO, {})
end, {})

--
-- Run Current Open JS file
keymap.set('n', '<Leader>8', function()
  local filetype = vim.bo.filetype

  if filetype ~= 'javascript' then
    vim.api.nvim_notify("This command only support on javascript file", vim.log.levels.ERROR, {})
    return
  end

  local current_file = vim.fn.expand('%:p')
  local f = assert(io.popen("node " .. current_file, "r"))
  local s = assert(f:read("*a"))
  f:close()
  vim.api.nvim_notify(s, vim.log.levels.INFO, {})
end)

vim.api.nvim_create_user_command('Silicon', function()
  local filetype = vim.bo.filetype
  local response = io.popen("silicon --from-clipboard --output ~/Screenshot/Silicon/$(date +%Y%m%d%H%M%S).png -l " ..
    filetype)

  if (response == nil) then
    print('Screenshot success')
    return
  end

  local result = response:read("*a")
  response:close()
  print(result)
end, {})

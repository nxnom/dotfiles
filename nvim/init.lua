require('base')
require('highlights')
require('maps')
require('plugins')
require('commands')

local local_config = 'local'
if pcall(require, local_config) then
  require(local_config)
end

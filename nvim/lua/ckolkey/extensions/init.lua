-- https://github.com/megalithic/dotfiles/blob/main/config/nvim/lua/mega/globals.lua
-- global lua extensions
if os.getenv("NVIM_DEBUG") then
  require('ckolkey.extensions.debug')
end

require('ckolkey.extensions.table')
require('ckolkey.extensions.string')

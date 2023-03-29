-- https://github.com/megalithic/dotfiles/blob/main/config/nvim/lua/mega/globals.lua
-- global lua extensions
if os.getenv("NVIM_DEBUG") then
  require('extensions.debug')
end

require('extensions.table')
require('extensions.string')

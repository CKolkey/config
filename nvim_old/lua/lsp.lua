local M = {}

local function filepath_to_module(filepath)
  local module, _ = filepath:gsub(vim.fn.stdpath("config") .. "/lua/", ""):gsub(".lua", "")
  return module
end

local function load_servers()
  local servers = io.popen('find "' .. vim.fn.stdpath("config") .. "/lua/lsp/servers" .. '" -type f')
  for file in servers:lines() do
    require(filepath_to_module(file)).load()
  end
end

local function set_handlers()
  vim.lsp.handlers["textDocument/formatting"] = require("lsp.handlers.formatting")
end

function M.load()
  load_servers()
  set_handlers()
end

return M

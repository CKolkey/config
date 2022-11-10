local M = {}

local config = require("lsp.config")

-- cmd = { "nc", "localhost", "7658" }
function M.load()
  require("lspconfig").solargraph.setup({
    capabilities = config.capabilities,
    on_attach = config.on_attach_with_formatting,
    flags = { debounce_text_changes = 150 },
    cmd = { "solargraph", "stdio" },
    -- cmd = { "bundle", "exec", "solargraph", "stdio" },
  })
end

return M

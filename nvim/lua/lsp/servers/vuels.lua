local M = {}

local config = require("lsp.config")

function M.load()
  require("lspconfig").vuels.setup({
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    flags = { debounce_text_changes = 150 },
  })
end

return M

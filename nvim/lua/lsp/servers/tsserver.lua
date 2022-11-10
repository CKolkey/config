local M = {}

local config = require("lsp.config")

-- npm install -g typescript-language-server
function M.load()
  require("lspconfig").tsserver.setup({
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    flags = { debounce_text_changes = 150 },
  })
end

return M

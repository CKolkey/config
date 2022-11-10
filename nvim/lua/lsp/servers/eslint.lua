local M = {}

local config = require("lsp.config")

-- npm i -g vscode-langservers-extracted
function M.load()
  require("lspconfig").eslint.setup({
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    flags = { debounce_text_changes = 150 },
  })
end

return M

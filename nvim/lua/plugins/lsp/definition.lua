local M = {}

function M.setup()
  local _definition_handler = vim.lsp.handlers['textDocument/definition']

  vim.lsp.handlers['textDocument/definition'] = function(err, result, ctx, config)
    if not result then
      vim.notify("LSP: Could not find definition")
    end

    _definition_handler(err, result, ctx, config)
  end
end

return M

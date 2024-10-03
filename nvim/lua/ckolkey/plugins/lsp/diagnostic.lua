local M = {}

function M.request(client, buffer)
  return function()
    local params = vim.lsp.util.make_text_document_params(buffer)

    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        return
      end
      if not result then
        P("LSP: diagnostics returned no result")
        return
      end

      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = result.items }),
        { client_id = client.id }
      )
    end)
  end
end

return M

local M = {}

function M.hover()
  local line        = unpack(vim.api.nvim_win_get_cursor(0)) - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })

  if not vim.tbl_isempty(diagnostics) then
    vim.notify.dismiss({ pending = true, silent = true })

    for _, diagnostic in ipairs(diagnostics) do
      vim.notify(
        diagnostic.message,
        vim.diagnostic.severity[diagnostic.severity],
        {
          hide_from_history = true,
          timeout           = 100000,
          animate           = false,
          on_open           = function(win_id)
            vim.api.nvim_create_autocmd(
              { "ExitPre", "BufHidden", "BufLeave", "CursorMoved", "CursorMovedI" },
              {
                buffer   = 0,
                once     = true,
                callback = function()
                  pcall(vim.api.nvim_win_close, win_id, true)
                  return true
                end
              }
            )
          end,
        }
      )
    end
  end
end

function M.request(client, buffer)
  local callback = function()
    local params = vim.lsp.util.make_text_document_params(buffer)

    client.request(
      'textDocument/diagnostic',
      { textDocument = params },
      function(err, result)
        if err then return end
        if not result then return end

        vim.lsp.diagnostic.on_publish_diagnostics(
          nil,
          vim.tbl_extend('keep', params, { diagnostics = result.items }),
          { client_id = client.id }
        )
      end
    )
  end

  return callback
end

return M

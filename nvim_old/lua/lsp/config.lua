local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.on_attach_with_formatting = function(...)
  M.on_attach(...)
  M.formatting_on_attach(...)
end

local format_callback = function(client, bufnr)
  if not vim.b.saving_format then
    vim.b.format_changedtick = vim.api.nvim_buf_get_changedtick(0)
    vim.b.format_curpos = vim.api.nvim_win_get_cursor(0)
    client.request("textDocument/formatting", vim.lsp.util.make_formatting_params({}), nil, bufnr)
  end
end

M.formatting_on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    utils.nnoremap("<leader><leader>", function()
      format_callback(client, bufnr)
    end, { buffer = true })

    require("autocmds").define("LspFormatOnSave", {
      {
        event    = "BufWritePost",
        buffer   = bufnr,
        callback = function() format_callback(client, bufnr) end,
      },
    })

    vim.api.nvim_buf_set_var(bufnr, "format_use_lsp", true)
  end
end

M.on_attach = function(client, bufnr)
  if client.supports_method("textDocument/definition") then
    utils.nnoremap("<C-]>", vim.lsp.buf.definition, { buffer = true })
  end

  if client.supports_method("textDocument/implementation") then
    utils.nnoremap("gi", vim.lsp.buf.implementation, { buffer = true })
  end

  if client.supports_method("textDocument/hover") then
    -- utils.nnoremap("K", vim.lsp.buf.hover, { buffer = true })
  end

  if client.supports_method("textDocument/references") then
    utils.nnoremap("gr", vim.lsp.buf.references, { buffer = true })
  end

  if client.supports_method("textDocument/signatureHelp") then
    require("lsp_signature").on_attach({ fixpos = true, padding = " " }, bufnr)
  end
end

return M

local telescope = require("telescope.builtin")

return function(options)
  return function(client, bufnr)
    local keymaps  = { normal = {} }
    local autocmds = {}
    local opts     = { noremap = true, buffer = bufnr }

    if client.supports_method("textDocument/definition") then
      keymaps.normal["<c-]>"] = { telescope.lsp_definitions, opts }
    end

    if client.supports_method("textDocument/references") then
      keymaps.normal["gr"] = { telescope.lsp_references, opts }
    end

    if client.supports_method("textDocument/implementation") then
      keymaps.normal["gi"] = { telescope.lsp_implementations, opts }
    end

    if client.supports_method("workspace/symbol") then
      keymaps.normal["gs"] = { telescope.lsp_workspace_symbols, opts }
    end

    if client.supports_method("textDocument/publishDiagnostics")
        or client.supports_method("textDocument/diagnostic")
    then
      autocmds.lsp_diagnostics_hover = {
        desc = "Show diagnostics when you hold cursor",
        {
          event    = "CursorHold",
          callback = require("plugins.lsp.diagnostic").hover,
          buffer   = bufnr
        }
      }
    end

    -- neovim doesn't support this method yet
    if client.supports_method("textDocument/diagnostic") then
      autocmds.fetch_diagnostics = {
        desc = "Request diagnostics",
        {
          event    = { 'BufEnter', 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged' },
          callback = require("plugins.lsp.diagnostic").request(client, bufnr),
          buffer   = bufnr
        }
      }
    end

    if client.supports_method("textDocument/signatureHelp") then
      require("lsp_signature").on_attach({ fixpos = true, padding = " " }, bufnr)
    end

    if client.supports_method("textDocument/codeAction") then
      keymaps.normal["<leader>ca"] = { vim.lsp.buf.code_action, opts }
    end

    if client.supports_method("textDocument/rename") then
      keymaps.normal["R"] = { vim.lsp.buf.rename, opts }
    end

    if client.supports_method("textDocument/formatting") and not options.disable_formatting then
      vim.api.nvim_buf_set_var(bufnr, "format_with_lsp", true)

      keymaps.normal["<leader><leader>"] = {
        function() require("plugins.lsp.formatting").callback(client, bufnr) end,
        opts
      }

      autocmds.lsp_format_on_save = {
        desc = "Format buffer on save",
        {
          event    = "BufWritePost",
          callback = function() require("plugins.lsp.formatting").callback(client, bufnr) end,
          buffer   = bufnr,
        },
      }
    end

    require("utils.keymaps").load(keymaps)
    require("utils.autocmds").load(autocmds)
  end
end

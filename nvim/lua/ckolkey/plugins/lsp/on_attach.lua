local telescope = require("telescope.builtin")

return function(options)
  return function(client, bufnr)
    local keymaps = { normal = {} }
    local autocmds = {}
    local opts = { noremap = true, buffer = bufnr }

    if client.supports_method("textDocument/definition") then
      keymaps.normal["gd"] = { telescope.lsp_definitions, opts }
    end

    if client.supports_method("textDocument/references") then
      keymaps.normal["gr"] = { telescope.lsp_references, opts }
    end

    if client.supports_method("textDocument/implementation") then
      keymaps.normal["gi"] = { telescope.lsp_implementations, opts }
    end

    if client.supports_method("workspace/symbol") then
      keymaps.normal["<c-s>"] = { telescope.lsp_workspace_symbols, opts }
    end

    if client.supports_method("inlayHint/resolve") then
      vim.lsp.inlay_hint.enable(bufnr, true)
    end

    if client.supports_method("textDocument/publishDiagnostics")
        or client.supports_method("textDocument/diagnostic")
    then
      autocmds.lsp_diagnostics_hover = {
        desc = "Show diagnostics when you hold cursor",
        {
          event = "CursorHold",
          callback = function()
            local position = vim.api.nvim_win_get_cursor(0)
            vim.defer_fn(function()
              if vim.deep_equal(vim.api.nvim_win_get_cursor(0), position) then
                vim.diagnostic.open_float(
                  {
                    focusable = false,
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                  }
                )
              end
            end, 1000)
          end,
          buffer = bufnr,
        },
      }
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
        function()
          require("ckolkey.plugins.lsp.formatting").callback(client, bufnr)
        end,
        opts,
      }

      autocmds.lsp_format_on_save = {
        desc = "Format buffer on save",
        {
          event = "BufWritePost",
          callback = function()
            require("ckolkey.plugins.lsp.formatting").callback(client, bufnr)
          end,
          buffer = bufnr,
        },
      }
    end

    require("ckolkey.utils.keymaps").load(keymaps)
    require("ckolkey.utils.autocmds").load(autocmds)
  end
end

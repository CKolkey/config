return function(client, bufnr)
  if client.supports_method("textDocument/signatureHelp") then
    require("lsp_signature").on_attach({ fixpos = true, padding = " " }, bufnr)
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_buf_set_var(bufnr, "format_with_lsp", true)
  end

  local telescope = require("telescope.builtin")
  local opts      = { noremap = true, silent = true, buffer = bufnr }
  local keymaps   = {
    normal = {
      ["R"]                = { vim.lsp.buf.rename, opts },
      ["<c-]>"]            = { telescope.lsp_definitions, opts },
      ["gr"]               = { telescope.lsp_references, opts },
      ["gi"]               = { telescope.lsp_implementations, opts },
      ["<c-s>"]            = { telescope.lsp_workspace_symbols, opts },
      ["<leader><leader>"] = { function() require("plugins.lsp.formatting").callback(client, bufnr) end, opts },
    }
  }

  local autocmds = {
    lsp_diagnostics_hover = {
      desc = "Show diagnostics when you hold cursor",
      {
        event = "CursorHold",
        callback = require("plugins.lsp.diagnostics").callback,
        buffer = bufnr
      }
    },
    lsp_format_on_save = {
      desc = "Format buffer on save",
      {
        event    = "BufWritePost",
        callback = function() require("plugins.lsp.formatting").callback(client, bufnr) end,
        buffer   = bufnr,
      },
    }
  }

  require("utils.keymaps").load(keymaps)
  require("utils.autocmds").load(autocmds)
end

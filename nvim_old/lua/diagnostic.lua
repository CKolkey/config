local M = {}

function M.load()
  vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticHint" })

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
end

local close_on_move = function(win_id)
    vim.api.nvim_command(
      string.format(
        "autocmd ExitPre,BufHidden,BufLeave,CursorMoved,CursorMovedI,WinScrolled <buffer> ++once lua pcall(vim.api.nvim_win_close, %d, true)",
        win_id
      )
    )
  end

M.line_diagnostics = function()
  local line = unpack(vim.api.nvim_win_get_cursor(0)) - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  local notifications = utils.plugin("notifications")

  if not vim.tbl_isempty(diagnostics) then
    vim.notify.dismiss({ pending = true, silent = true })

    for _, diagnostic in ipairs(diagnostics) do
      vim.notify(diagnostic.message, notifications.levels[diagnostic.severity], {
        hide_from_history = true,
        timeout = 100000,
        on_open = close_on_move,
      })
    end
  end
end

return M

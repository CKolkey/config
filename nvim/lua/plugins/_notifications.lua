local M = {}

local namespace = vim.api.nvim_create_namespace("nvim-notify")

local function diagnostic(bufnr, notif, highlights)
  local message = {
    " " .. notif.icon .. " " .. notif.message[1] .. " ",
    notif.message[2] and "     " .. notif.message[2] or nil,
  }

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, message)
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, { hl_group = highlights.icon, end_line = 0, end_col = 5 })
end

local bottom_right_static = {
  function(state)
    return {
      relative = "win",
      anchor = "SE",
      width = state.message.width,
      height = state.message.height,
      col = vim.api.nvim_win_get_width(0),
      row = vim.api.nvim_win_get_height(0) - (3 * #state.open_windows),
      border = "rounded",
      style = "minimal",
    }
  end,
  function()
    return {
      col = { vim.api.nvim_win_get_width(0) },
      time = true,
    }
  end,
}

M.styles = {
  minimal = "minimal",
  default = "default",
  diagnostic = diagnostic,
}

M.layouts = {
  bottom_right_static = bottom_right_static,
}

M.levels = { "error", "warn", "info", "debug", "trace" }

M.callbacks = {
  close_on_move = function(win_id)
    vim.api.nvim_command(
      string.format(
        "autocmd ExitPre,BufHidden,BufLeave,CursorMoved,CursorMovedI,WinScrolled <buffer> ++once lua pcall(vim.api.nvim_win_close, %d, true)",
        win_id
      )
    )
  end,
}

M.config = function()
  vim.notify = require("notify")

  require("notify").setup({
    stages = M.layouts.bottom_right_static,
    render = M.styles.diagnostic,
    minimum_width = 20,
    timeout = 5000,
    background_colour = "#000000",
    max_width = 100,
    max_height = 3,

    icons = {
      ERROR = require("colors").icons.error,
      WARN = require("colors").icons.warning,
      INFO = require("colors").icons.info,
      DEBUG = require("colors").icons.debug,
      TRACE = require("colors").icons.trace,
    },
  })
end

return M

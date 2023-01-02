return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  init = function()
    vim.notify = require("notify")
  end,
  config = {
    background_colour = require("config.ui").colors.bg0,
    render = function(bufnr, notif, highlights)
      local message = {}
      for i, line in ipairs(notif.message) do
        if line ~= "" then
          -- Replace heading with bold
          if string.match(line, "^# ") then
            line, _ = line:gsub("^# ", "*")
            line = line .. "*"
          end

          local prefix
          if i == 1 then
            prefix = " " .. notif.icon .. " │ "
          else
            prefix = "    │ "
          end

          table.insert(message, prefix .. line)
        end
      end

      vim.api.nvim_buf_set_option(bufnr, "filetype", "markdown")
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, message)

      -- Color Icon and vertical bar
      local namespace = require("notify.render.base").namespace()
      for i = 0, #message - 1 do
        vim.api.nvim_buf_set_extmark(bufnr, namespace, i, 0, { hl_group = highlights.icon, end_col = 10, strict = false })
      end
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.25)
    end,
    icons = {
      ERROR = require("config.ui").icons.error,
      WARN = require("config.ui").icons.warning,
      INFO = require("config.ui").icons.info,
      DEBUG = require("config.ui").icons.debug,
      TRACE = require("config.ui").icons.trace,
    },
  }
}

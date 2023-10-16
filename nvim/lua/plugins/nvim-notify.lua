return {
  "rcarriga/nvim-notify",
  init = function()
    vim.notify = require("notify")

    _G.old_print = print
    print = function(...)
      local print_safe_args = {}
      local _ = { ... }
      for i = 1, #_ do
        table.insert(print_safe_args, tostring(_[i]))
      end

      vim.notify(table.concat(print_safe_args, ' '), 2)
    end
  end,
  opts = {
    timeout   = 2000,
    top_down  = false,
    icons     = Icons.diagnostics,
    max_width = function() return math.floor(vim.o.columns * 0.75) end,
    render    = function(bufnr, notif, highlights)
      local message = {}
      for i, line in ipairs(notif.message) do
        if line ~= "" then
          local prefix = ""
          if notif.icon then
            if i == 1 then
              prefix = " " .. notif.icon .. " │ "
            else
              prefix = string.rep(" ", #notif.icon) .. "│ "
            end
          end

          -- Replace `heading` with `bold`
          line, _ = line:gsub("^# (.+)", "*%1*")
          table.insert(message, prefix .. line)
        end
      end

      vim.api.nvim_buf_set_option(bufnr, "filetype", "markdown")
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, message)
      -- Color Icon and vertical bar
      local namespace = require("notify.render.base").namespace()
      for i = 0, #message - 1 do
        vim.api.nvim_buf_set_extmark(bufnr, namespace, i, 0, { hl_group = highlights.icon, end_col = 9, strict = false })
      end
    end,
  }
}

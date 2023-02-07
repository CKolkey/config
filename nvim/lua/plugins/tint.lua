return {
  "levouh/tint.nvim",
  enabled = false,
  opts = {
    tint_background_colors = false,
    highlight_ignore_patterns = {
      "WinSeparator", "Status.*", "Indent.*", "Telescope.*", "Neogit.*"
    },
    window_ignore_function = function(winid)
      local bufid    = vim.api.nvim_win_get_buf(winid)
      local buftype  = vim.api.nvim_buf_get_option(bufid, "buftype")
      local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

      return buftype == "terminal"
          or buftype == "nofile"
          or buftype == "quickfix"
          or floating
    end
  }
}

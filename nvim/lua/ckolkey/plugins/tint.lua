return {
  "levouh/tint.nvim",
  enabled = false,
  opts = {
    focus_change_events = {
      focus = { "WinEnter", "FocusGained" },
      unfocus = { "WinLeave", "FocusLost" },
    },
  }
}

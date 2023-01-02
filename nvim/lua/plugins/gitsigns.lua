return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = {
    signs = {
      add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr" },
      change = { hl = "GitSignsChange", text = "▌", numhl = "GitSignsChangeNr" },
      topdelete = { hl = "GitSignsDelete", text = "▔", numhl = "GitSignsDeleteNr" },
      delete = { hl = "GitSignsDelete", text = "▁", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "GitSignsChange", text = "▁", numhl = "GitSignsChangeNr" },
    },
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "right_align",
      delay = 10,
      ignore_whitespace = false,
    },
    numhl = false,
    current_line_blame_formatter = "<author>:<author_time:%Y-%m-%d> - <summary>",
  }
}

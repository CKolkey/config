return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  opts = {
    current_line_blame_formatter = "<author>:<author_time:%Y-%m-%d> - <summary>",
    signs                        = {
      -- add          = { text = "▌" },
      -- change       = { text = "▌" },
      -- topdelete    = { text = "▔" },
      -- delete       = { text = "▁" },
      -- changedelete = { text = "▁" },
      -- untracked    = { text = "▌" }
    },
    current_line_blame_opts      = {
      virt_text         = true,
      virt_text_pos     = "right_align",
      delay             = 1,
      ignore_whitespace = false,
    },
  }
}

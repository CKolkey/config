return {
  "anuvyklack/pretty-fold.nvim",
  enabled = false,
  opts = {
    sections = {
      left = {
        'content',
      },
      right = {
        ' ', 'number_of_folded_lines', ' (', 'percentage', ')'
      }
    },
    fill_char = "─",
    add_close_pattern = 'last_line'
  }
}

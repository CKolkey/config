return {
  "anuvyklack/pretty-fold.nvim",
  config = {
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

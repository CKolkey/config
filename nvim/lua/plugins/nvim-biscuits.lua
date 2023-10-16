return {
  'code-biscuits/nvim-biscuits',
  enabled = false,
  opts = {
    default_config = {
      min_distance = 5,
      trim_by_words = true,
      max_length = 1
    },
    language_config = {
      ruby = {
        prefix_string = "# "
      },
      lua = {
        prefix_string = "-- "
      }
    }
  }
}

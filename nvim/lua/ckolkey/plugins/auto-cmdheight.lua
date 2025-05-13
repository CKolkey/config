return {
  "jake-stewart/auto-cmdheight.nvim",
  lazy = false,
  opts = {
    -- max cmdheight before displaying hit enter prompt.
    max_lines = 5,

    -- number of seconds until the cmdheight can restore.
    duration = 2,

    -- whether key press is required to restore cmdheight.
    remove_on_key = true,

    -- always clear the cmdline after duration and key press.
    -- by default it will only happen when cmdheight changed.
    clear_always = false,
  }
}

return {
  "rmagatti/auto-session",
  opts = {
    log_level = "error",
    suppress_dirs = { "~/" },
    auto_session_use_git_branch = nil,
    post_restore_cmds = {
      function()
        pcall(vim.treesitter.start)
      end,
    },
  }
}

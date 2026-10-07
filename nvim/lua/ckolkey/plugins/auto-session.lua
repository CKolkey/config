return {
  "rmagatti/auto-session",
  opts = {
    log_level = "error",
    suppress_dirs = { "~/" },
    auto_session_use_git_branch = nil,
    post_restore_cmds = {
      function()
        local bufs = {}
        local win_ids = vim.api.nvim_tabpage_list_wins(0)
        for _, win_id in ipairs(win_ids) do
          local buf = vim.api.nvim_win_get_buf(win_id)
          if not bufs[buf] then
            bufs[buf] = true
          end
        end

        for buf, _ in pairs(bufs) do
          pcall(vim.treesitter.start, buf)
        end
      end,
    },
  }
}

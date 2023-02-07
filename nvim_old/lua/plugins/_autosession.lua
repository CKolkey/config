local M = {}

M.config = function()
  require("auto-session").setup({
    log_level = "error",
    auto_session_suppress_dirs = { "~/" },
    auto_session_use_git_branch = nil,
  })
end

return M

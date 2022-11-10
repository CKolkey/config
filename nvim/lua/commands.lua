local M = {}

local commands = {
  [[command! Format lua require("functions").format()]],
  [[command! Ecredendtials call EcredentialsRails()]],
  [[command! -nargs=1 GitDiff call s:get_diff_files(<q-args>)]],
}

function M.load()
  for _, command in ipairs(commands) do
    vim.cmd(command)
  end
end

return M

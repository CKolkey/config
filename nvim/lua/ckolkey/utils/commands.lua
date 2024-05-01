local M = {}

function M.load(definitions)
  for command, func in pairs(definitions) do
    vim.api.nvim_create_user_command(command, func, {})
  end
end

return M

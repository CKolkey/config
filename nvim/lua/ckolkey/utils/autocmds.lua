local M = {}

local function command_opts(autocmd, command, group, desc)
  local opts = utils.table_except(autocmd, { "callback" })
  return vim.tbl_deep_extend("force", opts, { group = group, command = command, desc = desc })
end

local function callback_opts(autocmd, callback, group, desc)
  local opts = utils.table_except(autocmd, { "command" })
  return vim.tbl_deep_extend("force", opts, { group = group, callback = callback, desc = desc })
end

function M.load(definitions)
  for group, autocmds in pairs(definitions) do
    vim.api.nvim_create_augroup(group, { clear = true })
    local desc = utils.table_pop(autocmds, "desc")

    for _, autocmd in pairs(autocmds) do
      local event = utils.table_pop(autocmd, "event")
      local commands = utils.table_wrap(utils.table_pop(autocmd, "command"))
      local callbacks = utils.table_wrap(utils.table_pop(autocmd, "callback"))

      if not vim.tbl_isempty(commands) then
        for _, command in pairs(commands) do
          vim.api.nvim_create_autocmd(event, command_opts(autocmd, command, group, desc))
        end
      end

      if not vim.tbl_isempty(callbacks) then
        for _, callback in pairs(callbacks) do
          vim.api.nvim_create_autocmd(event, callback_opts(autocmd, callback, group, desc))
        end
      end
    end
  end
end

return M

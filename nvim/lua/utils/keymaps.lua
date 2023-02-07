local M = {}

local mode_sign = {
  insert = "i",
  normal = "n",
  terminal = "t",
  visual = "v",
  visual_block = "x",
  command = "c",
  operator_pending = "o",
  select = "s",
  replace = "r",
}

function M.load(mappings)
  for mode, mapping in pairs(mappings) do
    for key, value in pairs(mapping) do
      local options = {}

      if type(value) == "table" then
        options = value[2]
        value = value[1]
      end

      options = vim.tbl_extend("force", { silent = true }, options)
      vim.keymap.set(mode_sign[mode], key, value, options)
    end
  end
end

return M

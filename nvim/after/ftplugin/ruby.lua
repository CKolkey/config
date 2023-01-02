local function cmd_string(open)
  return [[:let b:rspec_alt = eval('rails#buffer().alternate()') ]]
    .. [[| lua RubyCreateRspecFile(vim.b.rspec_alt, ']]
    .. open
    .. [[')]]
end

vim.api.nvim_buf_create_user_command(0, "AC", cmd_string("e"), {})
vim.api.nvim_buf_create_user_command(0, "ASC", cmd_string("split"), {})
vim.api.nvim_buf_create_user_command(0, "AVC", cmd_string("vsplit"), {})

function RubyCreateRspecFile(alt_filepath, open)
  local definitions = require("nvim-treesitter.locals").get_definitions_lookup_table(0)

  local class
  local methods = {}

  for _, definition in pairs(definitions) do
    if definition.kind == "function" then
      local node_text = vim.treesitter.get_node_text(definition.node, 0)
      if node_text ~= "initialize" then
        table.insert(methods, node_text)
      end
    elseif definition.kind == "type" then
      class = vim.treesitter.get_node_text(definition.node, 0)
    end
  end

  vim.cmd(":silent " .. open .. " " .. alt_filepath)

  local template = {
    "# frozen_string_literal: true",
    "",
    'require "rails_helper"',
    "",
    "RSpec.describe " .. class .. " do",
  }

  for _, method in ipairs(methods) do
    table.insert(template, '  describe "#' .. method .. '" do')
    table.insert(template, "  end")
    table.insert(template, "")
  end

  table.insert(template, #template, "end")

  vim.api.nvim_buf_set_lines(0, 0, #template, false, template)
  vim.api.nvim_win_set_cursor(0, { 6, 0 })
  vim.cmd(":write")
end

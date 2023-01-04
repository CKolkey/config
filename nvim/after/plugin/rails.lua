local function rails_app()
  if utils.file_in_cwd("Gemfile.lock") and utils.file_in_cwd("config/environment.rb")
  then
    return true
  else
    return false
  end
end

if _G.Rails or not rails_app() then
  return
end

_G.Rails = {
  root = vim.loop.cwd() .. "/",
  projections = {
    { pattern = "app/controllers([%w_/]*)/([%w_]+)%.rb$", template = "spec/requests%s/%s_spec.rb" },
    { pattern = "app/([%w_/]+)/([%w_]+)%.rb$", template = "spec/%s/%s_spec.rb" },
    { pattern = "spec/([%w_/]+)/([%w_]+)_spec%.rb$", template = "app/%s/%s.rb" },
  },
  fn = {}
}

function Rails.fn.find_alternate_file()
  local current = vim.fn.expand("%:p")
  if not vim.startswith(current, Rails.root) then
    return
  end

  current, _ = current:gsub("^" .. Rails.root, "")
  local alternate
  for _, projection in ipairs(Rails.projections) do
    if current:match(projection.pattern) then
      local path, file = current:match(projection.pattern)
      alternate = string.format(projection.template, path, file)
      break
    end
  end

  return alternate
end

function Rails.fn.build_spec_file(filepath, open)
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

  vim.cmd(":silent " .. open .. " " .. filepath)

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
  vim.cmd.write()
end

function Rails.fn.edit_alternate_file(cmd)
  local alternate = Rails.fn.find_alternate_file()
  if vim.loop.fs_stat(alternate) then
    vim.cmd[cmd](alternate)
  else
    Rails.fn.build_spec_file(alternate, cmd)
  end
end

function Rails.fn.get_last_migration()
  local migrations = {}
  for file in vim.fs.dir(Rails.root .. "db/migrate/", { depth = 0 }) do
    table.insert(migrations, file)
  end
  return "db/migrate/" .. migrations[#migrations]
end

Rails.commands = {
  ["A"] = {
    fn = function() Rails.fn.edit_alternate_file("edit") end,
  },
  ["AS"] = {
    fn = function() Rails.fn.edit_alternate_file("split") end,
  },
  ["AV"] = {
    fn = function() Rails.fn.edit_alternate_file("vsplit") end,
  },
  ["Emigration"] = {
    fn = function() vim.cmd.edit(Rails.fn.get_last_migration()) end
  },
  ["Eschema"] = {
    fn = function() vim.cmd.edit("db/schema.rb") end
  },
}

for cmd, def in pairs(Rails.commands) do
  vim.api.nvim_create_user_command(cmd, def.fn, def.opts or {})
end

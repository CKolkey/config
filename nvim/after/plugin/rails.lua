local function rails_app()
  if utils.file_in_cwd("Gemfile.lock") and utils.file_in_cwd("config/environment.rb") then
    return true
  else
    return false
  end
end

if _G.Rails or not rails_app() then
  return
end

_G.Rails = {
  root        = vim.loop.cwd() .. "/",
  fn          = {},
  icon        = " ",
  name        = "Rails",
  db_schema   = {
    tables      = {},
    inflections = {},
    timestamp   = 0
  },
  projections = {
    {
      pattern  = "app/controllers([%w_/]*)/([%w_]+)%.rb$",
      template = "spec/requests%s/%s_spec.rb"
    },
    {
      pattern  = "spec/requests([%w_/]*)/([%w_]+)_spec%.rb$",
      template = "app/controllers%s/%s.rb"
    },
    {
      pattern  = "app/([%w_/]+)/([%w_]+)%.rb$",
      template = "spec/%s/%s_spec.rb"
    },
    {
      pattern  = "spec/([%w_/]+)/([%w_]+)_spec%.rb$",
      template = "app/%s/%s.rb"
    },
  },
}

function Rails.fn.notice(message, level)
  level = level or vim.log.levels.INFO
  vim.notify(message, level, { icon = Rails.icon })
end

function Rails.fn.find_alternate()
  local current = vim.fn.expand("%:p")
  if not vim.startswith(current, Rails.root) then
    return
  end

  local alternate

  current, _ = current:gsub("^" .. Rails.root, "")

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
    [[# frozen_string_literal: true]],
    "",
    [[require "rails_helper"]],
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
  local alternate = Rails.fn.find_alternate()
  if not alternate then
    print("Rails: Couldn't find alternate file")
  end

  if vim.loop.fs_stat(alternate) then
    vim.cmd[cmd](alternate)
  else
    Rails.fn.build_spec_file(alternate, cmd)
  end
end

function Rails.fn.get_last_migration()
  local migrations = {}
  for file, type in vim.fs.dir(Rails.root .. "db/migrate/") do
    if type == "file" then
      table.insert(migrations, file)
    end
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
  ["Gmigration"] = {
    fn = function(args)
      vim.loop.spawn(
        "bundle",
        { args = { "exec", "rails", "g", "migration", args.args } },
        function(code)
          if code == 0 then
            vim.schedule(function() vim.cmd.Emigration() end)
          else
            print("rails exited with status " .. tostring(code))
          end
        end
      )
    end,
    opts = { nargs = 1 }
  },
  ["Eschema"] = {
    fn = function() vim.cmd.edit("db/schema.rb") end
  },
  ["Egemfile"] = {
    fn = function() vim.cmd.edit("Gemfile") end
  },
  ["Eroutes"] = {
    fn = function() vim.cmd.edit("config/routes.rb") end
  },
  ["Eenvrc"] = {
    fn = function() vim.cmd.edit(".envrc") end
  },
  -- ["RspecFailures"] = {
  --   fn = function()
  --     local Job = require("plenary.job")
  --
  --     Job:new({
  --       command = "bundle",
  --       args = { "exec", "rspec", "--format", "failures", "--only-failures" },
  --       cwd = vim.loop.cwd() .. "/bin",
  --       on_stdout = function(someting)
  --   P(something)
  --       end,
  --       -- on_exit = function(job, value)
  --       --   P(value)
  --       --   P(job:result())
  --       -- end
  --     }):start()
  --
  --
  --     -- local call = [[bundle exec rspec --format failures --out /tmp/rspec-failures-nvim --only-failures]]
  --     -- local handle = io.popen(call)
  --     -- handle:close()
  --
  --
  --   end
  -- }
}

for cmd, def in pairs(Rails.commands) do
  vim.api.nvim_create_user_command(cmd, def.fn, def.opts or {})
end

function Rails.fn.parse_schema()
  local schema    = io.open("db/schema.rb", "r"):read("*a")
  local tree_root = vim.treesitter.get_string_parser(schema, "ruby", {}):parse()[1]:root()
  local query     = vim.treesitter.query.parse_query("ruby", [[
          (call
            method: (identifier) @method (#eq? @method "create_table")
            arguments: (argument_list (string (string_content) @table))
            (do_block (body_statement) @columns)
          )
        ]])

  local tables = {}
  local table
  for id, node in query:iter_captures(tree_root, schema, 0, -1) do
    local text = vim.treesitter.query.get_node_text(node, schema)
    if query.captures[id] == "table" then
      table = text
    elseif query.captures[id] == "columns" then
      tables[table] = text
    end
  end

  return tables
end

function Rails.fn.schema_tables()
  local timestamp = io.popen("stat -f %m db/schema.rb", "r"):read()

  if Rails.db_schema.timestamp ~= timestamp then
    Rails.db_schema.tables    = Rails.fn.parse_schema()
    Rails.db_schema.timestamp = timestamp
  end

  return Rails.db_schema.tables
end

function Rails.fn.model_inflection(model)
  local function pluralize(name)
    local call = [[ruby -ractive_support/inflector -e 'puts ActiveSupport::Inflector.pluralize("]] .. name .. [[")']]
    return io.popen(call):read()
  end

  if not Rails.db_schema.inflections[model] then
    Rails.db_schema.inflections[model] = pluralize(model)
  end

  return Rails.db_schema.inflections[model]
end

require("utils.autocmds").load({
  show_schema = {
    desc = "Shows DB columns as virtual text",
    {
      event    = "BufEnter",
      pattern  = "app/models/*.rb",
      callback = function(event)
        local tables     = Rails.fn.schema_tables()
        local model      = event.file:match("^.+/(.+)%..+")
        local table_name = Rails.fn.model_inflection(model)

        if not tables[table_name] then return end

        local lines = vim.tbl_map(
          function(row)
            return { { "# " .. utils.strip(row, { "^%s*t%." }), "Comment" } }
          end,
          vim.split(tables[table_name], "\n")
        )

        table.insert(lines, { { "", "Comment" } })

        local ns = vim.api.nvim_create_namespace("ror")
        vim.api.nvim_buf_clear_namespace(event.buf, ns, 0, -1)
        vim.api.nvim_buf_set_extmark(event.buf, ns, 1, 0, { virt_lines = lines })
      end
    }
  }
})

vim.defer_fn(function() Rails.fn.notice("Loaded " .. Rails.name) end, 1000)

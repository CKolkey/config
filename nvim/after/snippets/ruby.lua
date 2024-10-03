local M = {}

M.snippets = {
  ib = {
    description = "Inline Block",
    "{ |",
    i(1),
    "| ",
    i(0),
    " }",
  },
  ["do"] = {
    description = "Multiline Block",
    "do |",
    i(1),
    "|",
    indent(),
    i(0),
    newline("end"),
  },
  ["it"] = {
    description = "RSpec 'it' block",
    'it "',
    i(1),
    '" do',
    indent(),
    i(0),
    newline("end"),
  },
  ["ex"] = {
    description = "RSpec expectation",
    "expect(",
    i(1),
    ").to ",
    i(0),
  },
  ["all"] = {
    description = "RSpec allow",
    "allow(",
    i(1),
    ").to receive(:",
    i(2),
    ").and_return(",
    i(0),
    ")",
  },
  ["let"] = {
    description = "RSpec let",
    "let(:",
    i(1),
    ") { ",
    i(0),
    " }",
  },
  ["sub"] = {
    description = "RSpec subject",
    "subject(:",
    i(1),
    ") { ",
    i(0),
    " }",
  },
  ["des"] = {
    description = "RSpec 'describe' block",
    'describe "',
    i(1),
    '" do',
    indent(),
    i(0),
    newline("end"),
  },
  ["con"] = {
    description = "RSpec 'context' block",
    'context "',
    i(1),
    '" do',
    indent(),
    i(0),
    newline("end"),
  },
  ["rspec"] = {
    description = "Top-level RSpec block",
    "RSpec.describe ",
    i(1),
    " do",
    indent(),
    i(0),
    newline("end"),
  },
  fro = {
    description = "Ruby Magic String Literal Comment",
    "# frozen_string_literal: true",
    newline(),
  },
  ar = {
    description = "attr_reader",
    "attr_reader :",
  },
  aw = {
    description = "attr_writer",
    "attr_writer :",
  },
  aa = {
    description = "attr_accessor",
    "attr_accessor :",
  },
  dc = {
    description = "RSpec described_class",
    "described_class",
  },
  rd = {
    description = "rubocop:disable comment with prefilled violation codes",
    f(function(_)
      local ignored_codes = {
        "Style/TrailingBodyOnMethodDefinition",
        "Lint/UnusedMethodArgument",
        "Style/MethodDefParentheses",
        "Naming/MethodParameterName",
        "Layout/MultilineBlockLayout",
      }

      local row = vim.api.nvim_win_get_cursor(0)[1] - 1
      local messages = vim
        .iter(vim.diagnostic.get(0, { lnum = row }))
        :map(function(tbl)
          return tbl.code
        end)
        :filter(function(code)
          return not vim.tbl_contains(ignored_codes, code)
        end)
        :totable()

      return "# rubocop:disable " .. table.concat(utils.table_unique(messages), ", ")
    end),
  },
  pri = {
    description = "private keyword",
    "private",
    newline(),
    newline(),
    i(0),
  },
  pro = {
    description = "protected keyword",
    "protected",
    newline(),
    newline(),
    i(0),
  },
  fbc = {
    description = "FactoryBot",
    "FactoryBot.create(:",
    i(0),
    ")",
  },
  fbb = {
    description = "FactoryBot",
    "FactoryBot.build(:",
    i(0),
    ")",
  },
}

M.autosnippets = {
  ["init"] = {
    description = "Instance Constructor. Automatically creates instance variables from params.",
    condition = function(line_to_cursor)
      return line_to_cursor:match("def ")
    end,
    "initialize(",
    i(1),
    ")",
    newline(),
    f(function(args)
      if args[1][2] then
        -- For some reason the function doesn't stop when you leave insert mode, so
        -- prevent bad input form fucking up the buffer. there should never be anything
        -- in args[1][2], only args[1][1]
        return
      end

      -- splits params at commas, strip non-name characters
      local params = vim.tbl_map(function(str)
        return utils.strip(str, { "%s+", "=(.*)", ":(.*)", "*", "&" })
      end, vim.split(args[1][1], ",", { trimempty = true }))

      -- Find longest string to get padding so '=' chars line up
      local padding = utils.longest_string(params)

      -- add text formatting
      return vim.tbl_map(function(str)
        return "  @" .. utils.left_pad(str, padding, " ") .. " = " .. str
      end, params)
    end, { 1 }),
    newline("end"),
  },
  ["@"] = {
    description = "automatically type out instance variables in constructor",
    condition = function(line_to_cursor)
      if not line_to_cursor:match("%s*") then
        return
      end

      local node = ts_utils.get_node_at_cursor()
      while node do
        if node:type() == "method" then
          break
        end
        node = node:parent()
      end

      if not node then
        return false
      end
      return vim.treesitter.get_node_text(node, 0):find("^def initialize")
    end,
    "@",
    i(1),
    " = ",
    ri(1),
    i(0),
  },
  ["defm"] = {
    description = "Create a memoized method",
    condition = function(line_to_cursor)
      return line_to_cursor:match("%s*")
    end,
    "def ",
    i(1),
    indent(),
    "@",
    ri(1),
    " ||= ",
    i(0),
    newline("end"),
  },
  ["defs"] = {
    description = "Singleton Method Definition",
    condition = function(line_to_cursor)
      return line_to_cursor:match("%s*")
    end,
    "def self.",
    i(0),
  },
  ["req"] = {
    description = "require",
    condition = function(line_to_cursor)
      return line_to_cursor == "req"
    end,
    'require "',
    i(0),
    '"',
  },
  ["rreq"] = {
    description = "require_relative",
    condition = function(line_to_cursor)
      return line_to_cursor == "rreq"
    end,
    'require_relative "',
    i(0),
    '"',
  },
}

return M

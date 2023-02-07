local M = {}

local types = require("luasnip.util.types")
local luasnip = require("luasnip")

M.config = function()
  luasnip.config.set_config({
    enable_autosnippets = true,
    history = true,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "<-", "Error" } },
        },
      },
    },
  })
end

-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/luasnip.lua
local snippet = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.text_node

local parse_nodes = function(val)
  if type(val) == "string" then
    return { t({ val }), i(0) }
  end

  if type(val) == "table" then
    for k, v in ipairs(val) do
      if type(v) == "string" then
        val[k] = t({ v })
      end
    end
  end

  return val
end

local compile = function(snippets)
  if not snippets then return {} end

  local result = {}
  for trigger, snip in pairs(snippets) do
    table.insert(
      result,
      snippet({ trig = trigger, dscr = snip.description }, parse_nodes(snip), { condition = snip.condition })
    )
  end

  return result
end

local header = [[
  local ls = require("luasnip")
  local s  = ls.snippet_node
  local is = ls.indent_snippet_node
  local t  = ls.text_node
  local i  = ls.insert_node
  local f  = ls.function_node
  local c  = ls.choice_node
  local d  = ls.dynamic_node
  local r  = ls.restore_node
  local ri = require("luasnip.extras").rep
  local ai = require("luasnip.nodes.absolute_indexer")
  local ts_locals = require "nvim-treesitter.locals"
  local ts_utils = require "nvim-treesitter.ts_utils"

  local newline = function(text)
    return t { "", text or "" }
  end

  local indent = function()
    return newline("  ")
  end
]]

function M.load_snippets(ft)
  local snippets_file = vim.loop.fs_open(vim.fn.stdpath("config") .. "/lua/snippets/" .. ft .. ".lua", "r", 292)

  if snippets_file then
    local ft_snippets = loadstring(header .. vim.loop.fs_read(snippets_file, vim.loop.fs_fstat(snippets_file).size))()

    luasnip.add_snippets(ft, compile(ft_snippets.snippets), { type = "snippets", key = ft })
    luasnip.add_snippets(ft, compile(ft_snippets.autosnippets), { type = "autosnippets", key = ft .. "_auto" })
    luasnip.refresh_notify(ft)
  end
end

function M.autoload_filetype()
  if vim.tbl_isempty(luasnip.available()[vim.o.filetype] or {}) then
    M.load_snippets(vim.o.filetype)
  end
end

return M

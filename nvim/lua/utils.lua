local M = {}
local utils = {}

-- Global deep-inspect function
function P(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

function R(...)
  return require(...)
end

function utils.delete_buf()
  require("notify").dismiss({})
  MiniBufremove.delete()
end

-- @params: fn, time
-- function utils.debounce(fn, time)
--   local running = false
--
-- end
-- utils.debounce = require("nvim-treesitter-playground.utils").debounce
-- https://github.com/runiq/neovim-throttle-debounce/blob/main/defer.lua
-- https://github.com/nvim-treesitter/playground/blob/master/lua/nvim-treesitter-playground/utils.lua
local run = false
function utils.debounce(fn, time)
  local timer = vim.loop.new_timer()

  return function(...)
    timer:stop()
    run = true

    local args = { ... }
    timer:start(
      time,
      0,
      vim.schedule_wrap(function()
        timer:stop()
        timer:close()
        if run then
          run = false
          fn(unpack(args))
        end
      end)
    )
  end
end

function utils.plugin(name)
  return require("plugins._" .. name)
end

-- Remove leading/trailing characters from string
function utils.strip(string, chars)
  if not chars then
    chars = { "%s+" } -- Default to whitespace
  end

  for i = 1, #chars do
    string = string:gsub(chars[i], "")
  end

  return string
end

-- Pad left side of string with chatacter to length
function utils.left_pad(str, len, char)
  if char == nil then
    char = " "
  end
  return str .. string.rep(char, len - #str)
end

-- Pad right side of string with chatacter to length
function utils.right_pad(str, len, char)
  if char == nil then
    char = " "
  end
  return string.rep(char, len - #str) .. str
end

function utils.table_except(table, keys)
  local new_table = vim.deepcopy(table)

  for _, key in pairs(keys) do
    new_table[key] = nil
  end

  return new_table
end

function utils.table_pop(table, key)
  local element = table[key]
  table[key] = nil
  return element
end

function utils.table_unique(table)
  -- make unique keys
  local hash = {}
  for _, v in ipairs(table) do
    hash[v] = true
  end

  -- transform keys back into values
  local res = {}
  for k, _ in pairs(hash) do
    res[#res + 1] = k
  end

  return res
end

-- Fing longest string in a table
function utils.longest_string(list)
  local l = 0
  for indx = 1, #list do
    if #list[indx] > l then
      l = #list[indx]
    end
  end
  return l
end

-- Ensure an object is a table
function utils.table_wrap(obj)
  if type(obj) == "table" then
    return obj
  else
    return { obj }
  end
end

-- Sets vim.g scope variables for a table, with a prefix as namespace
-- ex: set_globals({ a = 1 }, "pre_") would set: vim.g.pre_a = 1
function utils.set_globals(table, prefix)
  for opt, val in pairs(table) do
    vim.g[prefix .. opt] = val
  end
end

-- A map function that gets used by the modal keymappings.
-- Nice for one-off mappings
function utils.map(modes, key, result, options)
  options = vim.tbl_deep_extend("force", {
    remap = false,
    silent = true,
    expr = false,
    nowait = false,
  }, options or {})

  for _, mode in ipairs(utils.table_wrap(modes)) do
    vim.keymap.set(mode, key, result, options)
  end
end

--- Modal Keymap Functions {{{
function utils.nnoremap(key, result, options)
  utils.map("n", key, result, options)
end

function utils.nmap(key, result, options)
  utils.map("n", key, result, { remap = true })
end

function utils.inoremap(key, result, options)
  utils.map("i", key, result, options)
end

function utils.imap(key, result, options)
  utils.map("i", key, result, { remap = true })
end

function utils.vnoremap(key, result, options)
  utils.map("v", key, result, options)
end

function utils.vmap(key, result, options)
  utils.map("v", key, result, { remap = true })
end

function utils.tnoremap(key, result, options)
  utils.map("t", key, result, options)
end

function utils.tmap(key, result, options)
  utils.map("t", key, result, { remap = true })
end

function utils.onoremap(key, result, options)
  utils.map("o", key, result, options)
end

function utils.omap(key, result, options)
  utils.map("o", key, result, { remap = true })
end
-- }}}

function M.load()
  _G.utils = nil
  _G.utils = utils
end

return M

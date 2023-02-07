_G.utils = {}

Icons  = require("config.ui.icons")
Colors = require("config.ui.colors")

-- Global deep-inspect function
function P(...)
  vim.pretty_print(...)
end

function utils.delete_buf()
  require("notify").dismiss({})
  MiniBufremove.delete()
end

-- utils.debounce = require("nvim-treesitter-playground.utils").debounce
-- https://github.com/runiq/neovim-throttle-debounce/blob/main/defer.lua
-- https://github.com/nvim-treesitter/playground/blob/master/lua/nvim-treesitter-playground/utils.lua
-- local run = false
-- function utils.debounce(fn, time)
--   local timer = vim.loop.new_timer()
--
--   return function(...)
--     timer:stop()
--     run = true
--
--     local args = { ... }
--     timer:start(
--       time,
--       0,
--       vim.schedule_wrap(function()
--         timer:stop()
--         timer:close()
--         if run then
--           run = false
--           fn(unpack(args))
--         end
--       end)
--     )
--   end
-- end

function utils.file_in_cwd(filename)
  if vim.loop.fs_stat(vim.loop.cwd() .. "/" .. filename) then
    return true
  else
    return false
  end
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

function utils.print_and_clear(text, delay)
  print(text)
  vim.fn.timer_start(
    delay,
    function() vim.cmd.echo([['']]) end
  )
end

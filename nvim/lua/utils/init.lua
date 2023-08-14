_G.utils = {}

Icons = require("config.ui.icons")
Colors = require("config.ui.colors")

-- Global deep-inspect function
function P(...)
  vim.print(...)
end

-- Global inspection function that dumps output to buffer
function S(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, "\n"), "\n")
  vim.cmd("new scratch")
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)

  return ...
end

function utils.delete_buf()
  require("notify").dismiss({})
  MiniBufremove.delete()
end

function utils.file_in_cwd(filename)
  if vim.loop.fs_stat(vim.loop.cwd() .. "/" .. filename) then
    return true
  else
    return false
  end
end

-- @param filename string
-- @param mode string
function utils.safe_read_file(filename, mode)
  local file, err = io.open(filename, "r")
  if not file then
    error(err)
  end

  local content = file:read(mode or "*a")
  io.close(file)

  return content
end

function utils.safe_read_proc(cmd)
  local proc, err = io.popen(cmd, "r")
  if not proc then
    error(err)
  end

  local content = proc:read()
  io.close(proc)

  return content
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
  local local_print = _G.old_print or print

  local_print(text)
  vim.fn.timer_start(delay, function()
    local_print("")
  end)
end

if not table.unpack then
  table.unpack = unpack
end

if not table.pack then
  function table.pack(...)
    return { ... }
  end
end

--- Removes the given key from the table, returning its value.
---@param tbl table
---@param key any
---@return any
function table.except(tbl, key)
  local element = tbl[key]
  tbl[key] = nil
  return element
end

--- Reduces the given table returning a new table with only the given key values.
---@param tbl table
---@param keys any[]
---@return table<any, any>
function table.slice(tbl, keys)
  local result = {}

  for key, value in pairs(tbl) do
    if vim.tbl_contains(keys, key) then
      result[key] = value
    end
  end

  return result
end

--- Convert a list or map of items into a value by iterating all it's fields and transforming
--- them with a callback
---@generic T : table
---@param callback fun(T, T, key: string | number): T
---@param list T[]
---@param accum T
---@return T
function table.inject(list, callback, accum)
  for k, v in pairs(list) do
    accum = callback(accum, v, k)
    assert(accum ~= nil, "The accumulator must be returned on each iteration")
  end
  return accum
end

---@generic T : table
---@param callback fun(item: T, key: string | number, list: T[]): T
---@param list T[]
---@return T[]
function table.map(callback, list)
  return table.inject(list, function(accum, v, k)
    accum[#accum + 1] = callback(v, k, accum)
    return accum
  end, {})
end

--- Check if the target matches  any item in the list.
---@param target string
---@param list string[]
---@return boolean|string
function table.any(list, target)
  return table.inject(list, function(accum, item)
    if accum then return accum end

    if target:match(item) then
      return true
    end

    return accum
  end, false)
end

---Find an item in a list
---@generic T
---@param haystack T[]
---@param matcher fun(arg: T):boolean
---@return T
function table.find(haystack, matcher)
  local found
  for _, needle in ipairs(haystack) do
    if matcher(needle) then
      found = needle
      break
    end
  end
  return found
end

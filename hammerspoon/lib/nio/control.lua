local tasks = require("lib.nio.tasks")

local nio = {}

---@toc_entry nio.control
---@text
--- Provides primitives for flow control in async functions
---@class nio.control
nio.control = {}

--- Create a new event
---
--- An event can signal to multiple listeners to resume execution
--- The event can be set from a non-async context.
---
--- ```lua
---  local event = nio.control.event()
---
---  local worker = nio.run(function()
---    nio.sleep(1000)
---    event.set()
---  end)
---
---  local listeners = {
---    nio.run(function()
---      event.wait()
---      print("First listener notified")
---    end),
---    nio.run(function()
---      event.wait()
---      print("Second listener notified")
---    end),
---  }
--- ```
---@return nio.control.Event
function nio.control.event()
  local waiters = {}
  local is_set = false
  return {
    is_set = function()
      return is_set
    end,
    set = function(max_woken)
      if is_set then
        return
      end
      is_set = true
      local waiters_to_notify = {}
      max_woken = max_woken or #waiters
      while #waiters > 0 and #waiters_to_notify < max_woken do
        waiters_to_notify[#waiters_to_notify + 1] = table.remove(waiters)
      end
      if #waiters > 0 then
        is_set = false
      end
      for _, waiter in ipairs(waiters_to_notify) do
        waiter()
      end
    end,
    wait = tasks.wrap(function(callback)
      if is_set then
        callback()
      else
        waiters[#waiters + 1] = callback
      end
    end, 1),
    clear = function()
      is_set = false
    end,
  }
end

---@class nio.control.Event
---@field set fun(max_woken?: integer): nil Set the event and signal to all (or limited number of) listeners that the event has occurred. If max_woken is provided and there are more listeners then the event is cleared immediately
---@field wait async fun(): nil Wait for the event to occur, returning immediately if
--- already set
---@field clear fun(): nil Clear the event
---@field is_set fun(): boolean Returns true if the event is set

--- Create a new future
---
--- An future represents a value that will be available at some point and can be awaited upon.
--- The future result can be set from a non-async context.
--- ```lua
---  local future = nio.control.future()
---
---  nio.run(function()
---    nio.sleep(100 * math.random(1, 10))
---    if not future.is_set() then
---      future.set("Success!")
---    end
---  end)
---  nio.run(function()
---    nio.sleep(100 * math.random(1, 10))
---    if not future.is_set() then
---      future.set_error("Failed!")
---    end
---  end)
---
---  local success, value = pcall(future.wait)
---  print(("%s: %s"):format(success, value))
--- ```
---@return nio.control.Future
function nio.control.future()
  local waiters = {}
  local result, err, is_set
  local wait = tasks.wrap(function(callback)
    if is_set then
      callback()
    else
      waiters[#waiters + 1] = callback
    end
  end, 1)
  local wake = function()
    for _, waiter in ipairs(waiters) do
      waiter()
    end
  end
  return {
    is_set = function()
      return is_set
    end,
    set = function(value)
      if is_set then
        error("Future already set")
      end
      result = value
      is_set = true
      wake()
    end,
    set_error = function(message)
      if is_set then
        error("Future already set")
      end
      err = message
      is_set = true
      wake()
    end,
    wait = function()
      if not is_set then
        wait()
      end

      if err then
        error(err)
      end
      return result
    end,
  }
end

---@class nio.control.Future
---@field set fun(value): nil Set the future value and wake all waiters.
---@field set_error fun(message): nil Set the error for this future to raise to
---the waiters
---@field wait async fun(): any Wait for the value to be set, returning immediately if already set
---@field is_set fun(): boolean Returns true if the future is set

return nio.control

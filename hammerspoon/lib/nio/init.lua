local nio = {}
local tasks = require("lib.nio.tasks")
local control = require("lib.nio.control")

local log = hs.logger.new("hammerspoon", "debug")
---@tag nvim-nio

---@toc

---@text
---
--- A library for asynchronous IO in Neovim, inspired by the asyncio library in
--- Python. The library focuses on providing both common asynchronous primitives
--- and asynchronous APIs for Neovim's core.

---@toc_entry nio
---@class nio
nio = {}

nio.control = control
nio.tasks = tasks

--- Run a function in an async context. This is the entrypoint to all async
--- functionality.
--- ```lua
---   local nio = require("lib.nio")
---   nio.run(function()
---     nio.sleep(10)
---     print("Hello world")
---   end)
--- ```
---@param func function
---@param cb? fun(success: boolean,...) Callback to invoke when the task is complete. If success is false then the parameters will be an error message and a traceback of the error, otherwise it will be the result of the async function.
---@return nio.tasks.Task
function nio.run(func, cb)
  return tasks.run(func, cb)
end

--- Creates an async function with a callback style function.
--- ```lua
---   local nio = require("lib.nio")
---   local sleep = nio.wrap(function(ms, cb)
---     vim.defer_fn(cb, ms)
---   end, 2)
---
---   nio.run(function()
---     sleep(10)
---     print("Slept for 10ms")
---   end)
--- ```
---@param func function A callback style function to be converted. The last argument must be the callback.
---@param argc integer The number of arguments of func. Must be included.
---@param opts? nio.WrapOpts Additional options.
---@return function Returns an async function
function nio.wrap(func, argc, opts)
  return tasks.wrap(func, argc, opts)
end

---@class nio.WrapOpts
---@field strict? boolean If true (default), an error will be thrown if the wrapped function is called from a non-async context.

--- Takes an async function and returns a function that can run in both async
--- and non async contexts. When running in an async context, the function can
--- return values, but when run in a non-async context, a Task object is
--- returned and an extra callback argument can be supplied to receive the
--- result, with the same signature as the callback for `nio.run`.
---
--- This is useful for APIs where users don't want to create async
--- contexts but which are still used in async contexts internally.
---@param func async fun(...)
---@param argc? integer The number of arguments of func. Must be included if there are arguments.
function nio.create(func, argc)
  return tasks.create(func, argc)
end

--- Run a collection of async functions concurrently and return when
--- all have finished.
--- If any of the functions fail, all pending tasks will be cancelled and the
--- error will be re-raised
---@async
---@param functions function[]
---@return any[] Results of all functions
function nio.gather(functions)
  local results = {}

  local done_event = control.event()

  local err
  local running = {}
  for i, func in ipairs(functions) do
    local task = tasks.run(func, function(success, ...)
      if not success then
        err = ...
        done_event.set()
      end

      results[#results + 1] = { i = i, success = success, result = ... }
      if #results == #functions then
        done_event.set()
      end
    end)

    running[#running + 1] = task
  end

  done_event.wait()
  if err then
    for _, task in ipairs(running) do
      task.cancel()
    end
    error(err)
  end

  local sorted = {}
  for _, result in ipairs(results) do
    sorted[result.i] = result.result
  end

  return sorted
end

return nio

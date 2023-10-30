local coro = {}

local function append(source, ...)
    for k, v in ipairs({ ... }) do
        table.insert(source, v)
    end
    return source
end

function coro.wrap(func)
  return function()
    coroutine.wrap(func)()
  end
end

coro.exec = (function()
  local pathEnv = ""
  local fn = function(cmdWithArgs, callback, withLogin)
    if not coroutine.isyieldable() then
      print("this function cannot be invoked on the main Lua thread")
    end

    if callback == nil then
      callback = function(exitCode, stdOut, stdErr)
      end
    end

    local done = false
    local out = nil
    local code = nil

    local cmd = {}
    if withLogin == true then
      append(cmd, "-l", "-i", "-c")
    else
      append(cmd, "-c")
    end

    if pathEnv ~= "" then
      table.insert(cmd, "export PATH=\"" .. pathEnv .. "\";" .. cmdWithArgs)
    else
      table.insert(cmd, cmdWithArgs)
    end

    local t = hs.task.new(os.getenv("SHELL"), function(exitCode, stdOut, stdErr)
      callback(exitCode, stdOut, stdErr)
      -- if debugMode == true then
      --   log.i("cmd: ", cmdWithArgs)
      --   log.i("out: ", stdOut)
      --   log.i("err: ", stdErr)
      -- end
      code = exitCode
      out = stdOut
      done = true
    end, cmd)

    t:start()

    while done == false do
      coroutine.applicationYield()
    end

    return out, code
  end

  return function(cmdWithArgs, callback, withEnv)
    if pathEnv == "" then
      -- we are safe to call fn here because it should already be in a coroutine
      pathEnv = fn("echo -n $PATH", nil, true)
    end

    return fn(cmdWithArgs, callback, withEnv)
  end
end)()

return coro

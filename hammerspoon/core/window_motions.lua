local M = {}

local parse = require("lib.json").parse

local function _yabai(group, command)
  return os.execute("/usr/local/bin/yabai -m " .. group .. " --" .. command)
end

local function query(command)
  return parse(os.capture("/usr/local/bin/yabai -m query --" .. command, true))
end

local function yabai(commands, options)
  local opts = options or {}

  return function()
    local window = hs.window.focusedWindow()

    local success
    for _, command in ipairs(commands) do
      if not success then
        success = _yabai(command.group, command.command)
      end
    end

    if opts.keepFocus then
      window:focus()
    end
  end
end

local function getDisplaySpaces()
  return query("displays --display").spaces
end

local function emptySpaceOnDisplay(spaceID)
  return query("spaces --space " .. spaceID).windows[1] == nil
end

local function sendFocusedWindowToNewSpace()
  local window = hs.window.focusedWindow()

  local spaceID
  for i, id in ipairs(getDisplaySpaces()) do
    if emptySpaceOnDisplay(id) then
      spaceID = id
      break
    end
  end

  if not spaceID then
    hs.spaces.addSpaceToScreen(window:screen())
  end

  _yabai("window", "space " .. (spaceID or "last"))
  _yabai("space", "focus " .. (spaceID or "last"))

  window:focus()
end

function M.load()
  hs.hotkey.bind({ "cmd" }, "h", yabai({
    { group = "window", command = "focus west" },
    { group = "display", command = "focus west" },
  }))

  hs.hotkey.bind({ "cmd" }, "j", yabai({
    { group = "window", command = "focus south" },
    { group = "display", command = "focus south" },
  }))

  hs.hotkey.bind({ "cmd" }, "k", yabai({
    { group = "window", command = "focus north" },
    { group = "display", command = "focus north" },
  }))

  hs.hotkey.bind({ "cmd" }, "l", yabai({
    { group = "window", command = "focus east" },
    { group = "display", command = "focus east" },
  }))

  hs.hotkey.bind({ "option", "ctrl" }, "h", yabai({
      { group = "window", command = "swap west" },
      { group = "window", command = "display west" },
      { group = "window", command = "space prev" },
    }, { keepFocus = true })
  )

  hs.hotkey.bind({ "option", "ctrl" }, "l", yabai({
      { group = "window", command = "swap east" },
      { group = "window", command = "display east" },
      { group = "window", command = "space next" },
    }, { keepFocus = true })
  )

  hs.hotkey.bind({ "option", "ctrl" }, "j", yabai({
    { group = "window", command = "swap south" },
    { group = "window", command = "display south" },
  }, { keepFocus = true }))

  hs.hotkey.bind({ "option", "ctrl" }, "k", yabai({
    { group = "window", command = "swap north" },
    { group = "window", command = "display north" },
  }, { keepFocus = true }))

  hs.hotkey.bind({ "option", "ctrl" }, "r", yabai({ { group = "space", command = "rotate 90" } }))
  hs.hotkey.bind({ "option", "ctrl" }, "f", yabai({ { group = "window", command = "toggle float" } }))
  hs.hotkey.bind({ "option", "ctrl" }, "n", sendFocusedWindowToNewSpace)

  return M
end

return M

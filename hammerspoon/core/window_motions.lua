local M = {}

local parse = require("lib.json").parse

local function yabaiBinPath()
  if os.capture("/usr/bin/arch") == "arm64" then
    return "/opt/homebrew/bin/yabai"
  else
    return "/usr/local/bin/yabai"
  end
end

local function _yabai(group, command)
  return os.execute(yabaiBinPath() .. " -m " .. group .. " --" .. command)
end

local function query(command)
  return parse(os.capture(yabaiBinPath() .. " -m query --" .. command, true))
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

local function isEmptySpace(spaceID)
  local result = query("spaces --space " .. spaceID)
  return result and (result["first-window"] == 0 and result["last-window"] == 0)
end

local function getEmptySpace()
  for _, id in ipairs(getDisplaySpaces()) do
    if isEmptySpace(id) then
      return id
    end
  end

  -- No empty space found - create a new one
  local window = hs.window.focusedWindow()
  hs.spaces.addSpaceToScreen(window:screen())
  return "last"
end

local function sendFocusedWindowToNewSpace(opts)
  opts = opts or {}
  local window = hs.window.focusedWindow()
  local spaceID = getEmptySpace()

  _yabai("window", "space " .. spaceID)

  if opts.keepFocus then
    window:focus()
  else
    _yabai("space", "focus " .. spaceID)
  end
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
  hs.hotkey.bind({ "option", "ctrl" }, "n", function() sendFocusedWindowToNewSpace({keepFocus = true}) end)
  hs.hotkey.bind({ "option", "ctrl" }, "m", sendFocusedWindowToNewSpace)

  return M
end

return M

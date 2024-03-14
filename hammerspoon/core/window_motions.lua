local M = {}

local parse = require("lib.json").parse
local coro = require("lib.coro")
local frame = require("core.frame")

local function _yabai(group, command)
  return coro.exec("/opt/homebrew/bin/yabai -m " .. group .. " " .. table.concat(command, " "))
end

local function query(command)
  local out, _ = coro.exec("/opt/homebrew/bin/yabai -m query --" .. command)
  return parse(out)
end

local function yabai(commands, options)
  local opts = options or {}

  return function()
    local window = hs.window.focusedWindow()

    for _, command in ipairs(commands) do
      local _, code = _yabai(command.group, command.command)
      if code == 0 then
        break
      end
    end

    if opts.keepFocus then
      window:focus()
      frame.draw(window, "wm")
    end
  end
end

local function getDisplaySpaces()
  return query("displays --display").spaces
end

local function isEmptySpace(spaceID)
  local result = query("spaces --space " .. spaceID)
  return result and (result["first-window"] == 0 and result["last-window"] == 0 and #result["windows"] == 0)
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

  if opts.keepFocus then
    frame.suspend(function()
      for _, win in ipairs(window:otherWindowsSameScreen()) do
        win:focus()
        _yabai("window", { "--space", spaceID })
      end
    end)

    window:focus()
  else
    _yabai("window", { "--space", spaceID })
    _yabai("space", { "--focus", spaceID })
  end
end

function M.load()
  hs.hotkey.bind(
    { "cmd" },
    "h",
    coro.wrap(yabai({
      { group = "window", command = { "--focus", "west" } },
      { group = "display", command = { "--focus", "west" } },
    }))
  )

  hs.hotkey.bind(
    { "cmd" },
    "j",
    coro.wrap(yabai({
      { group = "window", command = { "--focus", "south" } },
      { group = "display", command = { "--focus", "south" } },
    }))
  )

  hs.hotkey.bind(
    { "cmd" },
    "k",
    coro.wrap(yabai({
      { group = "window", command = { "--focus", "north" } },
      { group = "display", command = { "--focus", "north" } },
    }))
  )

  hs.hotkey.bind(
    { "cmd" },
    "l",
    coro.wrap(yabai({
      { group = "window", command = { "--focus", "east" } },
      { group = "display", command = { "--focus", "east" } },
    }))
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "h",
    coro.wrap(yabai({
      { group = "window", command = { "--swap", "west" } },
      { group = "window", command = { "--display", "west" } },
      { group = "window", command = { "--space", "prev" } },
    }, { keepFocus = true }))
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "l",
    coro.wrap(yabai({
      { group = "window", command = { "--swap", "east" } },
      { group = "window", command = { "--display", "east" } },
      { group = "window", command = { "--space", "next" } },
    }, { keepFocus = true }))
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "j",
    coro.wrap(yabai({
      { group = "window", command = { "--swap", "south" } },
      { group = "window", command = { "--display", "south" } },
    }, { keepFocus = true }))
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "k",
    coro.wrap(yabai({
      { group = "window", command = { "--swap", "north" } },
      { group = "window", command = { "--display", "north" } },
    }, { keepFocus = true }))
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "r",
    coro.wrap(yabai({ { group = "space", command = { "--rotate", "90" } } }))
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "f",
    coro.wrap(yabai({ { group = "window", command = { "--toggle", "float" } } }))
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "n",
    coro.wrap(sendFocusedWindowToNewSpace, { keepFocus = true })
  )

  hs.hotkey.bind(
    { "option", "ctrl" },
    "m",
    coro.wrap(sendFocusedWindowToNewSpace)
  )

  return M
end

return M

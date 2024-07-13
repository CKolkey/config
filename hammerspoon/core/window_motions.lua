local M = {}

local log = hs.logger.new("hammerspoon", "debug")
local function log_debug(message)
  local caller = debug.getinfo(2).name or "unknown"
  log.d("[Window Motions][" .. caller .. "]: " .. hs.inspect(message))
end

local parse = require("lib.json").parse
local coro = require("lib.coro")
local frame = require("core.frame")

local function _yabai(group, command)
  local cmd = "/opt/homebrew/bin/yabai -m " .. group .. " " .. table.concat(command, " ")
  log_debug(cmd)

  return coro.exec(cmd)
end

local function query(command)
  local out, _ = coro.exec("/opt/homebrew/bin/yabai -m query --" .. command)
  -- local out = os.capture("/opt/homebrew/bin/yabai -m query --" .. command)
  local parsed = parse(out)
  log_debug({ command, parsed })

  return parsed
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

local function getSpaceWindows()
  return query("windows")
end


local function getScreenSpaces(screen)
  return hs.spaces.spacesForScreen(screen or hs.window.focusedWindow():screen())
end

local function isEmptySpace(spaceID)
  local result = query("spaces --space " .. spaceID)

  return (
    result
    and (result["first-window"] == 0
    and result["last-window"] == 0)
    -- and #result["windows"] == 0)
  )
end

local function getEmptySpace()
  local spaceID
  local spaces = getDisplaySpaces()
  local window = hs.window.focusedWindow()

  if hs.spaces.addSpaceToScreen(window:screen()) then
    spaceID = spaces[#spaces] + 1
  else
    for _, id in ipairs(spaces) do
      if isEmptySpace(id) then
        spaceID = id
        break
      end
    end
  end

  return spaceID
end

local function pruneEmptySpaces()
  local empty = {}
  local spaces = getDisplaySpaces()
  for _, id in ipairs(spaces) do
    if isEmptySpace(id) then
      table.insert(empty, 1, id)
    end
  end

  for _, id in ipairs(empty) do
    _yabai("space", { "--destroy", id })
  end
end
-- local function pruneEmptySpaces()
--   local emptySpaces = {}
--
--   log_debug("getting screen spaces")
--   for _, id in ipairs(getScreenSpaces()) do
--     log_debug(id)
--
--     local count = 0
--     local windows = hs.spaces.windowsForSpace(id)
--     for _, wid in ipairs(windows) do
--       local w = hs.window(wid)
--       if w and w:title() ~= "MenuBarCover" and w:title() ~= "" then
--         log_debug(w)
--         count = count + 1
--       end
--     end
--
--     if count == 0 then
--       table.insert(emptySpaces, id)
--     end
--   end
--
--   log_debug(emptySpaces)
--
--   for _, id in ipairs(emptySpaces) do
--     hs.spaces.removeSpace(id, false)
--   end
--   hs.spaces.closeMissionControl()
-- end

local function sendFocusedWindowToNewSpace(opts)
  opts = opts or {}
  local window = hs.window.focusedWindow()
  local spaceID = getEmptySpace()

  if not spaceID then
    -- log_debug("No space found - attempting to prune")
    -- pruneEmptySpaces()
    return
  end


  if opts.keepFocus then
    frame.suspend(function()
      for _, win in ipairs(getSpaceWindows()) do
        if not win["has-focus"] and win.subrole == "AXStandardWindow" then
          _yabai("window " .. win.id, { "--space", spaceID })
        end
      end
    end)
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

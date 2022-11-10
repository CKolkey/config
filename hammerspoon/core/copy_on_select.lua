-- Inspired by:
-- https://github.com/asmagill/hammerspoon-config-take2/blob/master/_scratch/x11CopyPaste.lua
-- https://github.com/Hammerspoon/hammerspoon/issues/2196
-- https://github.com/lodestone/macpaste

local eventtap = require("hs.eventtap")
local eventTypes = eventtap.event.types
local timer = require("hs.timer")

local M = {}

local dragCount = 0
local clickStack = {}

local function trackClick()
  clickStack[2] = clickStack[1]
  clickStack[1] = timer.secondsSinceEpoch()

  return false
end

local function incrementDragCount()
  dragCount = dragCount + 1

  return false
end

local function wasDoubleClick()
  if not clickStack[2] then
    return false
  end

  return clickStack[1] - clickStack[2] <= eventtap.doubleClickInterval()
end

local function wasDragging()
  return dragCount > 10
end

local function handleMouseUp()
  local additionalEvents = {}

  if wasDragging() or wasDoubleClick() then
    additionalEvents = {
      eventtap.event.newKeyEvent({ "cmd" }, "c", true),
      eventtap.event.newKeyEvent({ "cmd" }, "c", false),
    }
  end
  dragCount = 0

  return false, additionalEvents
end

M._mouseDownEvent = eventtap.new({ eventTypes.leftMouseDown }, trackClick)
M._mouseDragEvent = eventtap.new({ eventTypes.leftMouseDragged }, incrementDragCount)
M._mouseUpEvent = eventtap.new({ eventTypes.leftMouseUp }, handleMouseUp)

M.load = function()
  M._mouseDownEvent:start()
  M._mouseDragEvent:start()
  M._mouseUpEvent:start()

  return M
end

M.unload = function()
  M._mouseDownEvent:stop()
  M._mouseDragEvent:stop()
  M._mouseUpEvent:stop()

  return M
end

return M

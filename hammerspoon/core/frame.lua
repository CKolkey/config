local focusedWindow = hs.window.focusedWindow
local windowfilter = hs.window.filter
local rectangle = hs.drawing.rectangle
local log = hs.logger.new("frame")
log.i = P

local M = {}

local frame, windows, running, watcher

local config = {
  redrawEvents = {
    "windowCreated",
    "windowFocused",
    -- "windowUnfocused",
    "windowMoved",
    "windowOnScreen",
    "windowVisible",
  },
  hideEvents = {
    "windowDestroyed",
    "windowMinimized",
    "windowHidden",
    -- "windowNotInCurrentSpace",
    "windowNotOnScreen",
    "windowNotVisible",
  },
  level = "floating",
  behaviour = 9,
  color = {
    red = 152 / 255,
    green = 195 / 255,
    blue = 121 / 255,
    alpha = 1,
  },
  width = 8,
  radius = 14,
  padding = 3,
}

local function hideFrame()
  log.i("[Frame] Hiding frame")
  frame:hide()
  M.redrawTimer:start()
end

local function redrawFrame(event)
  local win = focusedWindow()
  if win then
    M.draw(win, event)
  else
    hideFrame()
  end
end

-- Exposed so window motions can call this directly instead of waiting for event
function M.draw(win, caller)
  caller = caller or "event"
  log.i("[Frame] (" .. caller .. ") Redrawing frame for window: " .. win:title())

  local f = win:frame()
  frame:setFrame({
    x = f.x - config.padding,
    y = f.y - config.padding,
    w = f.w + (config.padding * 2),
    h = f.h + (config.padding * 2),
  }):show()
end

M.redrawTimer = hs.timer.delayed.new(
  0.01,
  function()
    redrawFrame("timer")
    redrawFrame("timer")
  end
)

local function setupFrame()
  if frame then
    if next(frame) ~= nil then
      frame:delete()
    end
  end

  local f = { x = -5, y = 0, w = 1, h = 1 }
  frame = rectangle(f)
      :setFill(false)
      :setStroke(true)
      :setLevel(config.level)
      :setBehavior(config.behaviour)
      :setStrokeWidth(config.width)
      :setStrokeColor(config.color)
      :setRoundedRectRadii(config.radius, config.radius)
end

function M.load()
  M.stop()
  running = true

  setupFrame()
  watcher = hs.screen.watcher.new(redrawFrame):start()

  windows = windowfilter
      .copy(windowfilter.default, "wf-frame")
      :setOverrideFilter({
        -- focused = true,
        allowRoles = {
          ["AXStandardWindow"] = true,
          ["AXDialog"] = true,
        },
      })
      :rejectApp("Tuple")

  for _, event in ipairs(config.redrawEvents) do
    windows:subscribe(event, function()
      log.i("[Frame] " .. event .. " event")
      -- redrawFrame()
      M.redrawTimer:start()
    end)
  end

  for _, event in ipairs(config.hideEvents) do
    windows:subscribe(event, function()
      log.i("[Frame] " .. event .. " event")
      hideFrame()
    end)
  end
  -- windows:subscribe(config.redrawEvents, redrawFrame, true)
  -- windows:subscribe(config.hideEvents, hideFrame, true)
end

function M.stop()
  if not running then
    return
  end

  if frame then
    frame:delete()
  end

  running = nil
  windows:delete()
  windows = nil

  watcher:stop()
end

local fastRedrawTimer = hs.timer.delayed.new(0.01, redrawFrame)
function M.redrawFrame()
  fastRedrawTimer:start()
end

return setmetatable(M, { __gc = M.stop })

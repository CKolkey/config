local focusedWindow = hs.window.focusedWindow
local windowfilter = hs.window.filter
local rectangle = hs.drawing.rectangle

local M = {}

local frame, windows, running, watcher, paused

local config = {
  events = {
    "windowCreated",
    "windowFocused",
    "windowMoved",
    "windowOnScreen",
    "windowVisible",
    "windowDestroyed",
    "windowMinimized",
    "windowHidden",
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
  padding = 4,
}

local function redrawFrame(event)
  frame:hide()

  local win = focusedWindow()
  if win then
    M.draw(win, event)
  end
end

-- Exposed so window motions can call this directly instead of waiting for event
function M.draw(win, caller)
  caller = caller or "event"
  -- log.i("[Frame] (" .. caller .. ") Redrawing frame for window: " .. win:title())

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

local event_handler = function(_event)
  return function()
    if paused then
      return
    end

    -- log.i("[Frame] " .. event .. " event")
    if M.redrawTimer:running() then
      M.redrawTimer:stop()
    end

    M.redrawTimer:start()
  end
end

-- Prevent redrawing frame while function is called
function M.suspend(fn)
  paused = true
  fn()
  paused = false
end

function M.load()
  M.stop()
  paused = false
  running = true

  setupFrame()
  watcher = hs.screen.watcher.new(redrawFrame):start()

  windows = windowfilter
      .copy(windowfilter.default, "wf-frame")
      :setOverrideFilter({
        allowRoles = {
          ["AXStandardWindow"] = true,
          ["AXDialog"] = true,
        },
      })
      :rejectApp("Tuple")

  for _, event in ipairs(config.events) do
    windows:subscribe(event, event_handler(event))
  end
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

return setmetatable(M, { __gc = M.stop })

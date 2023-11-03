local M = {}

local log = hs.logger.new("hammerspoon", "debug")
local screen = require("hs.screen")

local sf

local function makeBorder()
  return hs.canvas.new({}):level("floating"):show()
end

local border = makeBorder()

local function resetBorder()
  log.i("[Border] Deleting border")
  border:delete()
  border = makeBorder()
  border:frame(sf)
end

local function getScreens()
  local screens = screen.allScreens()
  if #screens == 0 then
    log.w("Cannot get current screens")
    return
  end

  sf = screens[1]:fullFrame()

  for i = 2, #screens do
    local fr = screens[i]:frame()
    if fr.x < sf.x then
      sf.x = fr.x
    end
    if fr.y < sf.y then
      sf.y = fr.y
    end
    if fr.x2 > sf.x2 then
      sf.x2 = fr.x2
    end
    if fr.y2 > sf.y2 then
      sf.y2 = fr.y2
    end
  end

  border:frame(sf)
end

local function drawBorder(window, name, event)
  if border:isOccluded() then
    resetBorder()
  end

  local win = window or hs.window.focusedWindow()
  if win then
    log.i("[border] " .. (name or "unknown") .. " :: " .. (event or "unknown"))

    local frame = win:frame()
    local shape = {
      type             = "rectangle",
      action           = "stroke",
      strokeWidth      = 3.0,
      roundedRectRadii = {
        xRadius = 8,
        yRadius = 8
      },
      strokeColor = {
        red   = 152 / 255,
        green = 195 / 255,
        blue  = 121 / 255
      },
      frame = {
        x = frame.x,
        y = frame.y,
        h = frame.h,
        w = frame.w
      }
    }

    border:frame({ x = frame.x, y = frame.y, h = frame.h, w = frame.w })
    border:replaceElements(shape)
  end
end

local screenWatcher, allwindows
function M.load()
  -- P(win:subrole())

  screenWatcher = screen.watcher.new(getScreens):start()
  getScreens()

  allwindows = hs.window.filter.new():setOverrideFilter({
    allowRoles = {
      ['AXStandardWindow'] = true,
      ['AXDialog'] = true,
     -- ['AXSystemDialog'] = false
    }
  }):rejectApp("Tuple")

  allwindows:subscribe(
    {
      "windowCreated",
      "windowFocused",
      "windowMoved",
      "windowOnScreen",
      "windowVisible",
      "windowInCurrentSpace",
      "windowNotVisible",
    },
    drawBorder,
    true
  )

  drawBorder()
  border:frame(sf)
end

function M.stop()
  screenWatcher:stop()
  border:delete()
  allwindows:delete()
end

M.redraw = drawBorder

return setmetatable(M, { __gc = M.stop })
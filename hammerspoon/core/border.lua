local M = {}

local border

local function drawBorder()
  -- local start = os.clock()

  if border then
    border:delete()
  end

  local win = hs.window.focusedWindow()
  if win then
    local screen = win:screen():fullFrame()
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
      frame = { x = frame.x, y = frame.y, h = frame.h, w = frame.w }
    }

    border = hs.canvas.new(screen):appendElements(shape):show()
    -- print(string.format("elapsed time: %.2f\n", os.clock() - start))
  end
end

function M.load()
  -- P(win:subrole())

  local allwindows = hs.window.filter.new():setOverrideFilter({
    allowRoles = {
      ['AXStandardWindow'] = true,
      ['AXDialog'] = true,
     -- ['AXSystemDialog'] = false
    }
  }):rejectApp("Tuple")

  allwindows:subscribe(hs.window.filter.windowCreated, drawBorder)
  allwindows:subscribe(hs.window.filter.windowFocused, drawBorder)
  allwindows:subscribe(hs.window.filter.windowMoved, drawBorder)
  allwindows:subscribe(hs.window.filter.windowUnfocused, drawBorder)

  drawBorder()
end

M.redraw = drawBorder

return M

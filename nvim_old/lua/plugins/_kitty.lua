-- Based on https://github.com/knubie/vim-kitty-navigator

local M = {}

local window_directions = { h = "left", j = "bottom", k = "top", l = "right" }

-- Switches buffers if possible, otherwise attempts to switch KITTY window
local function navigate(direction)
  local window = vim.fn.winnr()

  -- Attempt VIM command
  vim.api.nvim_command("wincmd " .. direction)

  -- return if the window ID has been changed
  if window ~= vim.fn.winnr() then
    return
  end

  -- shell out to Kitty with command
  os.execute("kitty @ kitten neighboring_window.py " .. window_directions[direction])
end

function M.navigate_left()
  navigate("h")
end

function M.navigate_down()
  navigate("j")
end

function M.navigate_up()
  navigate("k")
end

function M.navigate_right()
  navigate("l")
end

return M

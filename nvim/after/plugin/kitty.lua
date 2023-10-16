-- Based on https://github.com/knubie/vim-kitty-navigator

if _G.Kitty then
  return
end

_G.Kitty = {
  navigate = {},
  opts = {
    window_directions = { h = "left", j = "bottom", k = "top", l = "right" }
  }
}

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
  os.execute("kitty @ kitten neighboring_window.py " .. Kitty.opts.window_directions[direction])
end

function Kitty.navigate.left()
  navigate("h")
end

function Kitty.navigate.bottom()
  navigate("j")
end

function Kitty.navigate.top()
  navigate("k")
end

function Kitty.navigate.right()
  navigate("l")
end

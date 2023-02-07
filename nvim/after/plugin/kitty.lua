-- Based on https://github.com/knubie/vim-kitty-navigator

if _G.Kitty then
  return
end

_G.Kitty = {
  fn = {},
  navigate = {},
  opts = {
    window_directions = { h = "left", j = "bottom", k = "top", l = "right" }
  }
}

-- Switches buffers if possible, otherwise attempts to switch KITTY window
function Kitty.fn.navigate(direction)
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

function Kitty.navigate.left() Kitty.fn.navigate("h") end

function Kitty.navigate.bottom() Kitty.fn.navigate("j") end

function Kitty.navigate.top() Kitty.fn.navigate("k") end

function Kitty.navigate.right() Kitty.fn.navigate("l") end

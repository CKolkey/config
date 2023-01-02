-- Yells at you if you spam h/l to navigate on a line
local id
for _, key in ipairs({ "h", "l" }) do
  local count = 0

  vim.keymap.set("n", key, function()
    if count >= 10 then
      print("Hold it!")
    else
      count = count + 1
      vim.defer_fn(function()
        count = count - 1
      end, 5000)

      return key
    end
  end, { expr = true })
end

if vim.g.did_load_motions_helper then
  return
end
vim.g.did_load_motions_helper = true

-- Yells at you if you spam a motion to navigate on a line
---@param key string
---@param modes string|string[]
---@param action fun(): string?
---@param opts table
local function nag(key, modes, action, opts)
  local count = 0
  vim.keymap.set(modes, key, function()
    if count >= 10 then
      utils.print_and_clear("Hold it!", 2000)
      return
    end

    count = count + 1
    vim.defer_fn(function() count = count - 1 end, 5000)
    return action()
  end, opts)
end

for _, key in ipairs({ "h", "l" }) do
  nag(key, "n", function() return key end, { expr = true, silent = true })
end

-- camelCase/snake_case-aware word motions, via nvim-spider
for _, key in ipairs({ "w", "e", "b" }) do
  nag(key, { "n", "o", "x" }, function() require("spider").motion(key) end, { silent = true, desc = "Spider " .. key })
end

vim.keymap.set({ "n", "o", "x" }, "ge", function() require("spider").motion("ge") end,
  { silent = true, desc = "Spider ge" })

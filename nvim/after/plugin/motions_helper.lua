if vim.g.did_load_motions_helper then
  return
end
vim.g.did_load_motions_helper = true

-- Yells at you if you spam h/l to navigate on a line
for _, key in ipairs({ "h", "l" }) do
  local count = 0
  vim.keymap.set("n", key, function()
    if count >= 10 then
      utils.print_and_clear("Hold it!", 2000)
    else
      count = count + 1
      vim.defer_fn(function() count = count - 1 end, 5000)
      return key
    end
  end, { expr = true, silent = true })
end

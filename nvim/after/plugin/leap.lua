local ok, leap = pcall(require, "leap")
if not ok then
  return
end

vim.api.nvim_create_user_command(
  "LeapOmni",
  function()
    leap.leap({ target_windows = { vim.api.nvim_get_current_win() } })
  end,
  {}
)

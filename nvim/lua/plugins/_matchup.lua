local M = {}

M.setup = function()
  local opts = {
    matchparen_deferred = 1,
    matchparen_hi_surround_always = 1,
    delim_noskips = 2,
    matchparen_offscreen = { method = "popup" },
  }

  utils.set_globals(opts, "matchup_")
end

return M

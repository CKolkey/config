return {
  "andymass/vim-matchup",
  event = "BufReadPost",
  init = function()
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_hi_surround_always = 1
    vim.g.matchup_delim_noskips = 2
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end
}

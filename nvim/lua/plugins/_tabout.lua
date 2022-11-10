local M = {}

M.config = function()
  require("tabout").setup({
    -- tabkey = '<c-e>',
    -- backwards_tabkey = '<c-a>',
    -- act_as_tab = false,
    -- act_as_shift_tab = false,
    enable_backwards = true,
    completion = false,
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
    },
    ignore_beginning = true,
    exclude = {},
  })
end

return M

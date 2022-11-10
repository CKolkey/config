local M = {}

M.config = function()
  require("indent_blankline").setup({
    filetype_exclude = {
      "starter",
      "vimwiki",
      "man",
      "gitmessengerpopup",
      "diagnosticpopup",
      "lspinfo",
      "packer",
      "help",
      "neotree",
      "NeogitStatus",
      "checkhealth",
      "TelescopePrompt",
      "TelescopeResults",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    use_treesitter_scope = true,
    space_char_blankline = " ",
    show_foldtext = false,
    strict_tabs = true,
    max_indent_increase = 1,
    show_current_context = false,
    show_current_context_start = false,
    context_highlight_list = { "IndentBlanklineContext" },
    viewport_buffer = 100,
  })


  -- require("autocmds").define(
  --   "IndentBlanklineContextAutogroup",
  --   {
  --     {
  --       desc = "Debounce refresh for IndentBlankline",
  --       event = "CursorMoved",
  --       callback = function()
  --         -- utils.debounce(require("indent_blankline").refresh, 300)()
  --       end
  --     }
  --   }
  -- )

end

return M

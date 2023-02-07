return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  init = function()
    vim.g.indent_blankline_char = "▎"
    vim.g.indent_blankline_char_blankline = "▎"
  end,
  opts = {
    filetype_exclude               = {
      "lazy",
      "neotest-summary",
      "man",
      "gitmessengerpopup",
      "diagnosticpopup",
      "lspinfo",
      "help",
      "neo-tree",
      "NeogitStatus",
      "checkhealth",
      "TelescopePrompt",
      "TelescopeResults",
    },
    buftype_exclude                = { "terminal" },
    show_trailing_blankline_indent = false,
    use_treesitter_scope           = true,
    space_char_blankline           = " ",
    show_foldtext                  = false,
    strict_tabs                    = true,
    max_indent_increase            = 1,
    show_current_context           = false,
    show_current_context_start     = false,
    context_highlight_list         = { "IndentBlanklineContext" },
    viewport_buffer                = 100,
  }
}

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
  -- init = function()
  --   vim.g.indent_blankline_char = "▎"
  --   vim.g.indent_blankline_char_blankline = "▎"
  -- end,
  opts = {
    scope = {
      enabled = false,
      show_start = true,
      show_end = true,
      highlight = "IndentBlanklineContext",
    },
    -- exlude = {
    --   filetype = {
    --     "lazy",
    --     "man",
    --     "gitmessengerpopup",
    --     "diagnosticpopup",
    --     "lspinfo",
    --     "help",
    --     "NeogitStatus",
    --     "checkhealth",
    --     "TelescopePrompt",
    --     "TelescopeResults",
    --     ""
    --   },
    -- },
    -- show_trailing_blankline_indent = false,
    -- space_char_blankline           = " ",
    -- show_foldtext                  = false,
    -- strict_tabs                    = true,
    -- max_indent_increase            = 1,
    -- context_highlight_list         = { "IndentBlanklineContext" },
    -- viewport_buffer                = 100,
  },
}

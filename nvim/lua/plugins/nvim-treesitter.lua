return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "andymass/vim-matchup",
    "RRethy/nvim-treesitter-endwise",
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- "windwp/nvim-ts-autotag",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  -- event = "BufReadPre",
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
  end,
  config = function()
    -- require("nvim-treesitter").define_modules({
    --   fold = {
    --     attach = function()
    --       vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    --       vim.opt.foldmethod = "expr"
    --       vim.cmd.normal("zx") -- recompute folds
    --     end,
    --     detach = function() end,
    --   },
    -- })

    require("nvim-treesitter.configs").setup({
      auto_install          = true,
      ensure_installed      = {
        "fish",
        "gitcommit",
        "gitignore",
        "help",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "ruby",
        "vim",
        "yaml",
      },
      playground            = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
      query_linter          = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      refactor              = {
        navigation = {
          enable = true,
          keymaps = {
            goto_definition = "<c-]>",
            goto_next_usage = "]]",
            goto_previous_usage = "[[",
          },
        },
        highlight_definitions = {
          enable = true,
          disable = { "help" },
          clear_on_cursor_move = true,
        },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "R",
          },
        },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
        opts = {
          ruby = "# %s",
        },
      },
      autotag               = { enable = false, },
      matchup               = { enable = true, },
      indent                = { enable = true, },
      highlight             = { enable = true, },
      endwise               = { enable = true, },
      --      fold                  = { enable = true, },
    })
  end,
}

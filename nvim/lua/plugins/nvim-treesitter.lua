return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "andymass/vim-matchup",
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = "BufReadPre",
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
  end,
  init = function()
    require("nvim-treesitter").define_modules({
      fold = {
        attach = function()
          vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
          vim.opt.foldmethod = "expr"
          vim.cmd.normal("zx") -- recompute folds
        end,
        detach = function() end,
      },
    })
  end,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "diff",
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
      auto_install = true,
      playground = {
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
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      refactor = {
        highlight_definitions = {
          enable = true,
          disable = { "help" },
          clear_on_cursor_move = true,
        },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
        },
      },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
          ruby = "# %s",
        },
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = false,
      },
      matchup = {
        enable = true,
        disable = { "help" },
      },
      textobjects = {
        select = {
          enable = false,
          lookahead = false,
          keymaps = {
            ["ib"] = "@block.inner",
            ["ab"] = "@block.outer",
            ["ica"] = "@call.inner",
            ["aca"] = "@call.outer",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aco"] = "@comment.outer",
            ["iif"] = "@conditional.inner",
            ["aif"] = "@conditional.outer",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            -- ["il"] = "@loop.inner",
            -- ["al"] = "@loop.outer",
            -- ["ipa"] = "@parameter.inner",
            -- ["apa"] = "@parameter.outer"
          },
        },
        swap = {
          enable = true,
          swap_next = { [">"] = "@swappable" },
          swap_previous = { ["<"] = "@swappable" },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
      endwise = {
        enable = true,
      },
      fold = {
        enable = true,
      },
    })
  end,
}

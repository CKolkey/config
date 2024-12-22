return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  dependencies = {
    "andymass/vim-matchup",
    "metiulekm/nvim-treesitter-endwise",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  opts = function()
    require("nvim-treesitter.configs").setup({
      auto_install = false,
      ignore_install = {},
      ensure_installed = {
        -- "comment",
        "bash",
        "fish",
        -- "gitcommit",
        "gitignore",
        "html",
        "embedded_template",
        "json",
        "lua",
        "luap",
        "markdown",
        "markdown_inline",
        "regex",
        "ruby",
        "vim",
        "vimdoc",
        "yaml",
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
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
          disable = function(lang, buffer)
            local skip = { "help" }

            return vim.api.nvim_buf_line_count(buffer) > 20000 or vim.tbl_contains(skip, lang)
          end,
          clear_on_cursor_move = true,
        },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "R",
          },
        },
      },
      -- context_commentstring = {
      --   enable         = true,
      --   enable_autocmd = false,
      --   opts           = {
      --     ruby = {
      --       __default      = "# %s",
      --       body_statement = "<%# %s"
      --     },
      --   },
      -- },
      highlight = {
        enable = true,
        disable = function(_lang, buffer)
          return vim.api.nvim_buf_line_count(buffer) > 50000
        end,
      },
      autotag = { enable = false },
      matchup = {
        enable = true,
        disable = function(_lang, buffer)
          return vim.api.nvim_buf_line_count(buffer) > 20000
        end,
      },
      indent = { enable = true },
      endwise = { enable = true },
    })

    -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    -- parser_config.luap = {
    --   install_info = {
    --     url = "https://github.com/vhyrro/tree-sitter-luap",
    --     files = { "src/parser.c" },
    --     branch = "main",
    --     readme_name = "lua patterns",
    --   },
    -- }
  end,
}

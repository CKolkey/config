return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-file-browser.nvim", dev = true }
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        multi_icon        = Icons.git.staged,
        entry_prefix      = "   ",
        selection_caret   = Icons.misc.current .. " ",
        borderchars       = {
          prompt  = { " ", " ", " ", " ", " ", " ", " ", " " },
          results = { " ", " ", " ", " ", " ", " ", " ", " " },
          preview = { "", "", "", "▌", "▌", "", "", "▌" },
        },
        layout_config     = {
          prompt_position = "top",
          preview_cutoff  = 120,
          height          = 0.99,
          width           = 0.99,
        },
        show_line         = false,
        prompt_title      = false,
        results_title     = false,
        preview_title     = false,
        prompt_prefix     = "  ",
        sorting_strategy  = "ascending",
        file_ignore_patterns = {
          '^.git/*',
          '^log/*',
          '^public/*',
          '^app/assets/builds/*',
          '^spec/vcr_cassettes/*',
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          -- "--hidden",
          "--column",
          "--smart-case",
          -- "--trim",
        },
        mappings          = {
          i = {
            ["<esc>"]   = actions.close,
            ["<tab>"]   = actions.toggle_selection + actions.move_selection_next,
            ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
            ["<c-n>"]   = actions.move_selection_next,
            ["<c-q>"]   = actions.send_selected_to_qflist,
            ["<c-s>"]   = actions.file_split,
            ["<cr>"]    = function(prompt_bufnr)
              local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              if #picker:get_multi_selection() > 1 then
                actions.send_selected_to_qflist(prompt_bufnr)
                vim.schedule(function()
                  vim.cmd("cc 1")
                  require("qf_helper").open("c")
                end)
              else
                actions.select_default(prompt_bufnr)
              end
            end,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type",
            "f",
            "--strip-cwd-prefix",
            "--color=never",
            "--hidden",
          }
        }
      },
      extensions = {
        ["zf-native"] = {
          file = {
            enable            = true,
            highlight_results = true,
            match_filename    = true,
          },
          generic = {
            enable            = true,
            highlight_results = true,
            match_filename    = false,
          },
        },
        file_browser = {
          layout_config = {
            height          = 0.4,
            prompt_position = "top",
          },
          theme             = "ivy",
          hide_parent_dir   = true,
          layout_strategy   = "bottom_pane",
          git_status        = false,
          previewer         = false,
          prompt_path       = true,
          hidden            = true,
          respect_gitignore = false,
          grouped           = true,
          border            = false,
        },
        live_grep_args = {
          auto_quoting = false,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            borderchars = {
              prompt  = { " ", " ", " ", " ", " ", " ", " ", " " },
              results = { " ", " ", " ", " ", " ", " ", " ", " " },
              preview = { "", "", "", "▌", "▌", "", "", "▌" },
            },
          }),
        },
      },
    })

    local original_edit = require("telescope.actions.set").edit
    require("telescope.actions.set").edit = function(...)
      original_edit(...)
      vim.cmd.stopinsert()
    end
  end
}

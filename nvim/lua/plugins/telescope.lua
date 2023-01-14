return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("telescope").setup({
      defaults = {
        borderchars = {
          prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
          results = { " ", " ", " ", " ", " ", " ", " ", " " },
          preview = { "", "", "", "▌", "▌", "", "", "▌" },
        },
        layout_config = {
          prompt_position = "top",
          preview_cutoff = 120,
          height = 0.99,
          width = 0.99,
        },
        show_line = false,
        prompt_title = false,
        results_title = false,
        preview_title = false,
        prompt_prefix = " ",
        sorting_strategy = "ascending",
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
        },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_next,
            ["<s-tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_previous,
            ["<c-n>"] = require("telescope.actions").move_selection_next,
            ["<c-q>"] = require("telescope.actions").send_selected_to_qflist,
            ["<cr>"] = function(prompt_bufnr)
              local actions = require("telescope.actions")
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
            ["<c-s>"] = require("telescope.actions").file_split,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--color=never" }
        }
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = false,
          case_mode = "smart_case",
        },
        ["zf-native"] = {
          file = {
            enable = true,
            highlight_results = true,
            match_filename = true,
          },
          generic = {
            enable = false,
          },
        },
      },
    })
  end
}

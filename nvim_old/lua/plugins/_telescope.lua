local M = {}

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local telescope = require("telescope")
local themes = require("telescope.themes")

local custom_actions = {}

function custom_actions.variable_selection(prompt_bufnr)
  local actions = require("telescope.actions")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()

  if num_selections > 1 then
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist()
    vim.schedule(function()
      vim.cmd("cc 1")
      vim.fn.RemoveEmptyBuffers()
    end)
  else
    actions.select_default(prompt_bufnr)
  end
end

M.config = function()
  telescope.setup({
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
          ["<esc>"] = actions.close,
          ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<c-n>"] = actions.move_selection_next,
          ["<c-q>"] = actions.send_selected_to_qflist,
          ["<cr>"] = custom_actions.variable_selection,
          ["<c-s>"] = actions.file_split,
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
        themes.get_dropdown(),
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

  telescope.load_extension("fzf")
  telescope.load_extension("zf-native")
  telescope.load_extension("ui-select")
  telescope.load_extension("harpoon")
end

return M

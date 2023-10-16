local live_grep = function()
  local filetype = vim.fn.expand("%:e")
  if filetype == "" then
    filetype = "*"
  end

  require("telescope").extensions.live_grep_args.live_grep_args({ debounce = 100 })

  local keys = vim.api.nvim_replace_termcodes([["" -g "*.]] .. filetype .. [["<c-a><right>]], true, false, true)

  vim.api.nvim_feedkeys(keys, "c", false)
end

local grep_current_word = function()
  local word = vim.fn.expand("<cword>")
  local filetype = vim.fn.expand("%:e")

  require("telescope").extensions.live_grep_args.live_grep_args({ debounce = 100 })

  local keys = vim.api.nvim_replace_termcodes([["" -g "*.]] .. filetype .. [["<c-a><right>]] .. word, true, false, true)

  vim.api.nvim_feedkeys(keys, "c", false)
end

local buffer_count = function()
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) or b == vim.api.nvim_get_current_buf() then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  return #bufnrs
end

return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim", dev = false },
  },
  keys = {
    { "-", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File drawer" },
    { "<c-g>", live_grep, desc = "Live grep" },
    { "<c-space>", grep_current_word, desc = "Grep current word" },
    { "<c-f>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<c-b>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<c-z>", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<m-r>", "<cmd>Telescope resume<cr>", desc = "Telescope resume" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        multi_icon = Icons.git.staged,
        entry_prefix = "   ",
        selection_caret = Icons.misc.current .. " ",
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
        prompt_prefix = "  ",
        sorting_strategy = "ascending",
        file_ignore_patterns = {
          "^.git/*",
          "^log/*",
          "^public/*",
          "^app/assets/builds/*",
          "^spec/vcr_cassettes/*",
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
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
            ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
            ["<c-n>"] = actions.move_selection_next,
            ["<c-q>"] = actions.send_selected_to_qflist,
            ["<c-s>"] = actions.file_split,
            ["<cr>"] = function(prompt_bufnr)
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
        buffers = {
          theme = "ivy",
          previewer = false,
          border = false,
          cwd_only = true,
          ignore_current_buffer = true,
          cache_picker = false,
          sort_lastused = true,
          layout_config = {
            height = function()
              return buffer_count() + 2
            end,
          },
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
        find_files = {
          find_command = {
            "fd",
            "--type",
            "f",
            "--strip-cwd-prefix",
            "--color=never",
            "--hidden",
          },
        },
      },
      extensions = {
        ["zf-native"] = {
          file = {
            enable = true,
            highlight_results = true,
            match_filename = true,
          },
          generic = {
            enable = true,
            highlight_results = true,
            match_filename = false,
          },
        },
        file_browser = {
          layout_config = {
            height = 0.4,
            prompt_position = "top",
          },
          theme = "ivy",
          quiet = true,
          use_ui_input = false,
          hide_parent_dir = true,
          layout_strategy = "bottom_pane",
          git_status = false,
          cache_picker = false,
          previewer = false,
          prompt_path = true,
          hidden = true,
          respect_gitignore = false,
          grouped = true,
          border = false,
        },
        live_grep_args = {
          auto_quoting = false,
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = false,
          override_file_sorter = false,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            borderchars = {
              prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
              results = { " ", " ", " ", " ", " ", " ", " ", " " },
              preview = { "", "", "", "▌", "▌", "", "", "▌" },
            },
          }),
        },
      },
    })

    -- local original_edit = require("telescope.actions.set").edit
    -- require("telescope.actions.set").edit = function(...)
    --   original_edit(...)
    --   vim.cmd.stopinsert()
    -- end
  end,
}

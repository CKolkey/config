local live_grep = function()
  local filetype = vim.fn.expand("%:e")
  if filetype == "" then
    filetype = "*"
  end

  require("telescope").extensions.live_grep_args.live_grep_args({ debounce = 100 })

  -- local exclusions = [[-g!"log/**" -g!".git/**" -g!".pnpm-store/**" -g!"node_modules/**" -g!"*.log""]]
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

local function action(key)
  return function(...)
    return require("telescope.actions")[key](...)
  end
end

return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim",   build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim", dev = false },
  },
  keys = {
    { "-",          "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File drawer" },
    { "<c-g>",      live_grep,                                                       desc = "Live grep" },
    { "<c-space>",  grep_current_word,                                               desc = "Grep current word" },
    { "<leader>ec", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>",              desc = "Find config file" },
    { "<leader>ep", "<cmd>Telescope find_files cwd=~/.local/share/nvim/lazy<cr>",    desc = "Find plugin file" },
    { "<c-f>",      "<cmd>Telescope find_files<cr>",                                 desc = "Find files" },
    { "<c-b>",      "<cmd>Telescope buffers<cr>",                                    desc = "Buffers" },
    { "<c-z>",      "<cmd>Telescope help_tags<cr>",                                  desc = "Help" },
    { "<m-r>",      "<cmd>Telescope resume<cr>",                                     desc = "Telescope resume" },
  },
  opts = {
    defaults = {
      multi_icon = Icons.misc.v_pipe,
      entry_prefix = " ",
      selection_caret = Icons.misc.v_pipe,
      borderchars = {
        prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
        results = { " ", " ", " ", " ", " ", " ", " ", " " },
        preview = { "", "", "", "▌", "▌", "", "", "▌" },
      },
      show_line = false,
      prompt_title = false,
      results_title = false,
      preview_title = false,
      prompt_prefix = "  ",
      sorting_strategy = "ascending",
      file_ignore_patterns = {
        "^.git\\/.*",
        "^log\\/.*",
        "^public/*",
        "^app/assets/builds/*",
        -- "^spec/vcr_cassettes/*",
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
          ["<esc>"] = action("close"),
          ["<c-s>"] = action("file_split"),
          ["<cr>"] = function(prompt_bufnr)
            local actions = require("telescope.actions")
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            if #picker:get_multi_selection() > 1 then
              actions.send_selected_to_qflist(prompt_bufnr)
              actions.open_qflist(prompt_bufnr)
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
        layout_config = {
          width = 0.99,
          height = 0.99,
          flip_columns = 150,
          prompt_position = "top",
          vertical = {
            mirror = true,
          },
        },
        layout_strategy = "flex",
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
          enable = false,
          highlight_results = false,
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
        layout_config = {
          width = 0.99,
          height = 0.99,
          prompt_position = "top",
          flip_columns = 150,
        },
        layout_strategy = "flex",
        auto_quoting = false,
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = false,
        case_mode = "smart_case",
      },
      -- ["ui-select"] = {
      --   require("telescope.themes").get_dropdown({
      --     borderchars = {
      --       prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
      --       results = { " ", " ", " ", " ", " ", " ", " ", " " },
      --       preview = { "", "", "", "▌", "▌", "", "", "▌" },
      --     },
      --   }),
      -- },
    },
  },
}

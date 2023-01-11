return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
  },
  cmd = "Neotree",
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1

    -- Override popup options to make it relative to editor, not cursor
    local popups = require("neo-tree.ui.popups")
    local popup_options = popups.popup_options

    popups.popup_options = function(title, min_width, override_options)
      local options = popup_options(title, min_width, override_options)

      -- options.relative = "editor"
      -- options.position = {
      --   col = math.floor(vim.o.columns / 2 - (options.size / 2) + 20),
      --   row = math.floor(vim.o.lines * 0.4)
      -- }

      options.size = 38
      options.position = {
        row = 0,
        col = 0
      }

      return options
    end
  end,
  opts = {
    close_if_last_window      = false,
    hide_root_node            = true,
    popup_border_style        = { " ", " ", " ", " ", " ", "▔", " ", " " },
    enable_git_status         = true,
    enable_diagnostics        = false,
    event_handlers            = {
      {
        event = "file_opened",
        handler = function(file_path)
          require("neo-tree").close_all()
        end,
      },
    },
    default_component_configs = {
      indent = {
        indent_size        = 2,
        padding            = 0,
        with_expanders     = nil,
        with_markers       = true,
        indent_marker      = "│ ",
        last_indent_marker = "╰─ ",
        highlight          = "NeoTreeIndentMarker",
      },

      icon = {
        folder_empty  = Icons.misc.folder_empty,
        folder_closed = Icons.misc.folder_closed,
        folder_open   = Icons.misc.folder_open,
        default       = Icons.misc.file,
      },

      name = {
        trailing_slash = true,
        use_git_status_colors = true,
      },

      git_status = {
        symbols = Icons.git,
      },
    },

    nesting_rules = {},

    filesystem = {
      follow_current_file = true,
      use_libuv_file_watcher = true,

      commands = {
        delete_node_without_confirm = function(state, callback)
          require("neo-tree.sources.filesystem.lib.fs_actions").delete_node(state.tree:get_node().path, callback, true)
        end,
        copy_relative_path = function(state)
          local path, _ = string.gsub(state.tree:get_node():get_id(), vim.fn.getcwd() .. "/", "")
          path, _ = string.gsub(path, "[\n\r]", "")

          vim.notify("Copied: '" .. path .. "'")
          vim.api.nvim_command("silent !echo '" .. path .. "' | pbcopy")
        end
      },

      window = {
        position = "left",
        width    = 40,
        mappings = {
          ["l"]       = "open",
          ["s"]       = "open_split",
          ["v"]       = "open_vsplit",
          ["h"]       = "close_node",
          ["."]       = "toggle_hidden",
          ["R"]       = "refresh",
          ["/"]       = "filter_on_submit",
          ["<space>"] = "toggle_preview",
          ["<c-x>"]   = "clear_filter",
          ["n"]       = "add",
          ["dd"]      = "delete_node_without_confirm",
          ["d"]       = "none",
          ["r"]       = "rename",
          ["yy"]      = "copy_to_clipboard",
          ["Y"]       = "copy_relative_path",
          ["x"]       = "cut_to_clipboard",
          ["p"]       = "paste_from_clipboard",
          ["c"]       = "copy",
          ["m"]       = "move",
          ["q"]       = "close_window",
          ["-"]       = "close_window",
        },
      },

      components = {
        harpoon_index = function(config, node, state)
          local success, index = pcall(require("harpoon.mark").get_index_of, node:get_id())
          if success and index and index > 0 then
            return {
              text = string.format(" [%d]", index),
              highlight = config.highlight or "NeoTreeDirectoryIcon",
            }
          else
            return {}
          end
        end,

        icon_padding = function()
          return { text = " " }
        end,
      },

      renderers = {
        file = {
          { "icon_padding" },
          { "icon" },
          { "icon_padding" },
          { "name", use_git_status_colors = true },
          { "harpoon_index", highlight = "NeoTreeHarpoonIcon" },
          { "git_status", highlight = "NeoTreeDimText" },
        },

        directory = {
          { "icon_padding" },
          { "icon" },
          { "icon_padding" },
          { "name", use_git_status_colors = true },
        },
      },

      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = { ".DS_Store", "thumbs.db" },
        never_show = { ".DS_Store", "node_modules" },
      },
    },
  }
}

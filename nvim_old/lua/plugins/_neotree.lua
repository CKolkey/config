local M = {}

local copy_relative_path = function(state)
  local path, _ = string.gsub(state.tree:get_node():get_id(), vim.fn.getcwd() .. "/", "")
  path, _ = string.gsub(path, "[\n\r]", "")

  print("Copied: '" .. path .. "'")
  vim.api.nvim_command("silent !echo '" .. path .. "' | pbcopy")
end

local delete_node_without_confirm = function(state, callback)
  require("neo-tree.sources.filesystem.lib.fs_actions").delete_node(state.tree:get_node().path, callback, true)
end

M.config = function()
  vim.g.neo_tree_remove_legacy_commands = 1

  require("neo-tree").setup({
    close_if_last_window = false,
    hide_root_node = false,

    popup_border_style = { " ", " ", " ", " ", " ", " ", " ", " " },
    enable_git_status = true,
    enable_diagnostics = false,

    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          require("neo-tree").close_all()
        end,
      },
    },

    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 0,

        with_markers = true,
        indent_marker = "│ ",
        last_indent_marker = "╰─ ",
        highlight = "NeoTreeIndentMarker",

        with_expanders = nil,
        expander_collapsed = " ",
        expander_expanded = " ",
        expander_highlight = "NeoTreeExpander",
      },

      icon = {
        folder_empty = "",
        folder_closed = "",
        folder_open = "",
        default = "",
      },

      name = {
        trailing_slash = true,
        use_git_status_colors = true,
      },

      git_status = {
        symbols = {
          -- Change type
          added = " ",
          deleted = " ",
          modified = " ",
          renamed = " ",

          -- Status type
          untracked = " ",
          ignored = " ",
          unstaged = " ",
          staged = " ",
          conflict = " ",
        },
      },
    },

    nesting_rules = {},

    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,

      window = {
        position = "left",
        width = 40,
        mappings = {
          ["l"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["h"] = "close_node",
          ["."] = "toggle_hidden",
          ["R"] = "refresh",
          ["/"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["n"] = "add",
          ["dd"] = delete_node_without_confirm,
          ["d"] = "none",
          ["r"] = "rename",
          ["yy"] = "copy_to_clipboard",
          ["Y"] = copy_relative_path,
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination
          ["m"] = "move", -- takes text input for destination
          ["q"] = "close_window",
          ["-"] = "close_window",
        },

        popup = {
          border = {
            style = "rounded",
          },
          position = { col = "100%", row = "1" },
          size = function(state)
            local root_name = vim.fn.fnamemodify(state.path, ":~")
            local root_len = string.len(root_name) + 4

            return {
              width = math.max(root_len, 40),
              height = vim.o.lines - 6,
            }
          end,
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
          { "icon" },
          { "icon_padding" },
          { "name", use_git_status_colors = true },
          { "harpoon_index", highlight = "NeoTreeHarpoonIcon" },
          { "git_status", highlight = "NeoTreeDimText" },
        },

        directory = {
          { "icon" },
          { "icon_padding" },
          { "name", use_git_status_colors = true },
        },
      },

      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = { ".DS_Store", "thumbs.db" },
        never_show = { ".DS_Store" },
      },
    },

    buffers = {
      show_unloaded = true,
      window = {
        mappings = {
          ["dd"] = "buffer_delete",
        },
      },
    },

    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
    },
  })
end

return M

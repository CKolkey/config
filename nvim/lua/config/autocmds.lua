local definitions = {
  config_reloading = {
    {
      event = "BufWritePost",
      pattern = "*/nvim/lua/after/snippets/*.lua",
      command = "LuasnipReloadFilteypeSnippets",
      -- TODO: Load correct filetype
      -- callback = {
      --   function()
      --     local filetype = vim.fn.expand("<afile>"):match("^.*/(.*).lua$")
      --     utils.plugin("luasnip").load_snippets(filetype)
      --     print("Reloading Snippets: " .. filetype)
      --   end,
      -- },
    },
  },

  load_snippets = {
    desc = "Load snippets for filetype",
    { event = "BufEnter", command = "LuasnipAutoloadFilteypeSnippets" },
  },

  format_file = {
    desc = "Formatting File after write",
    { event = "BufWritePost", callback = require("utils.functions").format },
  },

  autoreload = {
    desc = "Automatically reloads buffer if it's changed externally",
    { event = { "FocusGained", "BufEnter", "CursorHold" }, command = "silent! checktime %" },
  },

  highlight_yank = {
    desc = "Visually highlight yanked area",
    {
      event = "TextYankPost",
      callback = function()
        vim.highlight.on_yank({ higroup = "VisualYank", timeout = 800, on_visual = true })
      end,
    },
  },

  auto_resize = {
    desc = "Resizes windows when screen area is resized",
    { event = "VimResized", command = "tabdo wincmd =" },
  },

  mkdir_on_save = {
    desc = "Auto-Create any missing folders when writing a file",
    { event = "BufWritePre", command = "call mkdir(expand('<afile>:p:h'), 'p')" },
  },

  auto_update_buffer = {
    desc = "Updates the buffer, with conditions",
    { event = "InsertLeave", callback = require("utils.functions").update_buffer, nested = true }
  },

  cursor_position = {
    desc = "Keeps cursor position when leaving insert mode, and reloads last position when opening buffer",
    { event = "InsertLeave", command = "normal `^" },
  },
}

require("utils.autocmds").load(definitions)

local M = {}

local definitions = {
  config_reloading = {
    {
      event = "BufWritePost",
      pattern = "*/nvim/lua/snippets/*.lua",
      callback = {
        function()
          local filetype = vim.fn.expand("<afile>"):match("^.*/(.*).lua$")
          utils.plugin("luasnip").load_snippets(filetype)
          print("Reloading Snippets: " .. filetype)
        end,
      },
    },
  },

  treesitter_install = {
    desc = "Lazily installs treesitter parsers",
    {
      event = "FileType",
      callback = function()
        local parsers = require("nvim-treesitter.parsers")
        local lang = parsers.get_buf_lang()
        if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
          vim.schedule_wrap(function()
            vim.cmd("TSInstallSync " .. lang)
          end)()
        end
      end,
    },
  },

  load_snippets = {
    desc = "Load snippets for filetype",
    {
      event = "BufEnter",
      callback = function()
        utils.plugin("luasnip").autoload_filetype()
      end,
    },
  },

  format_file = {
    desc = "Formatting File after write",
    { event = "BufWritePost", callback = require("functions").format },
  },

  formatting = {
    desc = "Simple Formatting for a buffer (Just trim whitespace)",
    { event = "BufWritePre", callback = "TrimWhitespace" },
  },

  autoreload = {
    desc = "Automatically reloads buffer if it's changed externally",
    { event = { "FocusGained", "BufEnter", "CursorHold" }, command = "silent! checktime %" },
  },

  neogit_config = {
    desc = "Some config stuff for neogit plugin",
    { event = "WinEnter", pattern = "Neogit*", command = "setl eventignore+=InsertEnter,InsertLeave" },
    { event = "WinLeave", pattern = "Neogit*", command = "setl eventignore-=InsertEnter,InsertLeave" },
  },

  line_number_toggle = {
    desc = "Toggles Relative/Absolute Line Numbering for Ins/Norm Modes",
    { event = "InsertLeave", command = "setlocal relativenumber" },
    { event = "InsertEnter", command = "setlocal norelativenumber" },
  },

  terminal_behavior = {
    desc = "Sets some nice defaults for a Terminal Buffer",
    { event = "WinEnter", pattern = "term://*", command = { "startinsert" } },
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
    desc = "Resizes buffers when screen area is resized",
    { event = "VimResized", command = "tabdo wincmd =" },
  },

  mkdir_on_save = {
    desc = "Auto-Create any missing folders when writing a file",
    { event = "BufWritePre", command = "call mkdir(expand('<afile>:p:h'), 'p')" },
  },

  cursor_position = {
    desc = "Keeps cursor position when leaving insert mode, and reloads last position when opening buffer",
    { event = "InsertLeave", command = "normal `^" },
    -- {
    --   event = "BufReadPost",
    --   command = [[if line("'\"") > 0 && line("'\"") <= line("$") && &ft != "help" | exe "normal g`\"zz" | endif]],
    -- },
  },

  diagnostics_cursor_hold = {
    desc = "Show diagnostics when you hold cursor",
    { event = "CursorHold", callback = require("diagnostic").line_diagnostics },
  },
}

local function command_opts(autocmd, command, group, desc)
  local opts = utils.table_except(autocmd, { "callback" })
  return vim.tbl_deep_extend("force", opts, { group = group, command = command, desc = desc })
end

local function callback_opts(autocmd, callback, group, desc)
  local opts = utils.table_except(autocmd, { "command" })
  return vim.tbl_deep_extend("force", opts, { group = group, callback = callback, desc = desc })
end

-- Commands can be defined as either a table of strings, or as a single string
-- Callbacks can be defined as either a table of strings/functions, or a single
-- string/function
function M.load()
  for group, autocmds in pairs(definitions) do
    M.define(group, autocmds)
  end
end

function M.define(group, autocmds)
  vim.api.nvim_create_augroup(group, { clear = true })
  local desc = utils.table_pop(autocmds, "desc")

  for _, autocmd in pairs(autocmds) do
    local event = utils.table_pop(autocmd, "event")
    local commands = utils.table_wrap(utils.table_pop(autocmd, "command"))
    local callbacks = utils.table_wrap(utils.table_pop(autocmd, "callback"))

    if not vim.tbl_isempty(commands) then
      for _, command in pairs(commands) do
        vim.api.nvim_create_autocmd(event, command_opts(autocmd, command, group, desc))
      end
    end

    if not vim.tbl_isempty(callbacks) then
      for _, callback in pairs(callbacks) do
        vim.api.nvim_create_autocmd(event, callback_opts(autocmd, callback, group, desc))
      end
    end
  end
end

return M

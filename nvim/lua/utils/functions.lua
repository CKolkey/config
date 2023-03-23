local M = {}

local function at_tip_of_undo_tree()
  local tree = vim.fn.undotree()
  return tree.seq_last == tree.seq_cur
end

function M.format()
  if vim.b.format_with_lsp then return end
  if not at_tip_of_undo_tree() then return end

  if vim.bo.modifiable and vim.bo.modified then
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! keeppatterns keepjumps %s/\s\+$//e]]) -- Strip Trailing Whitespace
    vim.cmd([[silent! keeppatterns keepjumps %s#\($\n\s*\)\+\%$##]]) -- Strip Empty lines at EOF
    vim.fn.winrestview(view)
    vim.cmd([[
       try
         undojoin | silent! update
       catch /E790/
         silent! update
       endtry
     ]])
  end
end

-- Insert debugger breakpoint for filetype
-- TODO: For ruby, we should be aware if we're in the middle of a method chain
--       and use `.tap { |o| debugger(pre: "info"); o }`
function M.debugger()
  local breakpoint = {
    javascript = "debugger",
    ruby       = 'debugger(pre: "info")',
    lua        = "P()"
  }

  if breakpoint[vim.o.filetype] then
    return "o" .. breakpoint[vim.o.filetype] .. "<esc>:w<cr>^"
  else
    print("No debugger found for " .. vim.o.filetype)
  end
end

-- Simple auto-save function that can be called via Autocmd
function M.update_buffer(event)
  -- and not vim.tbl_contains(excluded_filetypes, buffer.filetype)
  -- local excluded_filetypes = {
  --   "NeogitCommitView",
  -- }

  local callback = function()
    utils.print_and_clear("Saved " .. vim.fn.strftime("%H:%M:%S"), 1300)
  end

  local writable_buffer = vim.bo[event.buf].modifiable and vim.bo[event.buf].buftype == ""
  local file_exists     = vim.fn.expand("%") ~= ""
  local saved_recently  = (vim.b.timestamp or 0) == vim.fn.localtime()
  local being_formatted = (vim.b.saving_format or false)

  if writable_buffer
      and file_exists
      and not saved_recently
      and not being_formatted
  then
    vim.cmd("silent update")
    callback()
  end
end

--https://github.com/arsham/shark/blob/master/lua/commands.lua#L138
function M.unlink_snippets()
  local session = require("luasnip.session")
  local cur_buf = vim.api.nvim_get_current_buf()

  while true do
    local node = session.current_nodes[cur_buf]
    if not node then
      return
    end
    local user_expanded_snip = node.parent
    -- find 'outer' snippet.
    while user_expanded_snip.parent do
      user_expanded_snip = user_expanded_snip.parent
    end

    user_expanded_snip:remove_from_jumplist()
    -- prefer setting previous/outer insertNode as current node.
    session.current_nodes[cur_buf] = user_expanded_snip.prev.prev or user_expanded_snip.next.next
  end
end

-- quick.command("Profile", function()
--   vim.cmd.profile("start /tmp/profile.log")
--   vim.cmd.profile("file *")
--   vim.cmd.profile("func *")
--   vim.keymap.set("n", "<localleader>ss", function()
--     vim.cmd.profile("dump")
--     vim.cmd.profile("stop")
--     vim.keymap.del("n", "<localleader>ss")
--     vim.notify("Profile has been saved!")
--   end)
-- end, { desc = "start profiling to /tmp/profile.log. <leader>ss to stop!" })
--
return M

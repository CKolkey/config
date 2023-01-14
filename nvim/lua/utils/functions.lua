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
  local excluded_filetypes = {
    "NeogitCommitView",
    "terminal",
    "TelescopePromptNormal",
    "neo-tree",
  }

  local last_saved_at = vim.b.last_saved_at or 0
  local now           = vim.fn.strftime("%s")
  local message       = function() return "Saved " .. vim.fn.strftime("%H:%M:%S") end

  if vim.bo[event.buf].modifiable
      and vim.bo[event.buf].mod
      and now ~= last_saved_at -- Save at most once per second
      and not vim.tbl_contains(excluded_filetypes, vim.bo[event.buf].filetype)
      and not (vim.b.saving_format or false)
      and (vim.b.last_format_changedtick or 0) ~= vim.api.nvim_buf_get_changedtick(event.buf)
  then
    vim.cmd.update()
    print(message())
    vim.api.nvim_buf_set_var(event.buf, "last_saved_at", now)
    vim.fn.timer_start(1300, function() vim.cmd([[echon '']]) end)
    vim.cmd.doautocmd("BufWritePost")
  end
end

return M

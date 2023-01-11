local M = {}

local function cursor_has_moved(bufnr)
  local old = vim.api.nvim_buf_get_var(bufnr, "format_curpos")
  local now = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())

  -- P({
  --   old = vim.api.nvim_buf_get_var(bufnr, "format_curpos"),
  --   new = { now[1], now[2] - 1 },
  --   now = now,
  --   a = vim.deep_equal(old, { now[1], now[2] - 1 }),
  --   b = vim.deep_equal(old, now),
  --   c = not (vim.deep_equal(old, { now[1], now[2] - 1 }) or vim.deep_equal(old, now))
  -- })

  return not (vim.deep_equal(old, { now[1], now[2] - 1 }) or vim.deep_equal(old, now))
end

local function not_at_tip_of_undo_tree()
  local tree = vim.fn.undotree()
  return tree.seq_last ~= tree.seq_cur
end

local function no_result(result)
  return not result or vim.tbl_isempty(result)
end

local function not_in_normal_mode()
  return vim.api.nvim_get_mode().mode ~= "n"
end

local function new_changedtick_value(bufnr)
  return vim.api.nvim_buf_get_var(bufnr, "format_changedtick") ~= vim.api.nvim_buf_get_changedtick(bufnr)
end

local function in_snippet()
  return require("luasnip").in_snippet()
end

local function abort_formatting(result, bufnr)
  local no_res       = no_result(result)
  local wrong_mode   = not_in_normal_mode()
  local undo_tree    = not_at_tip_of_undo_tree()
  local cursor_moved = cursor_has_moved(bufnr)
  local new_tick     = new_changedtick_value(bufnr)
  local snippet      = in_snippet()

  -- P({
  --   no_result               = no_res,
  --   not_in_normal_mode      = wrong_mode,
  --   not_at_tip_of_undo_tree = undo_tree,
  --   cursor_has_moved        = cursor_moved,
  --   new_changedtick_value   = new_tick,
  --   in_snippet              = snippet
  -- })

  return no_res or wrong_mode or undo_tree or cursor_moved or new_tick or snippet
end

local function write_error(err, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local client_name = client and client.name or string.format("client_id=%d", ctx.client_id)

  vim.api.nvim_err_write(string.format("%s: %d: %s", client_name, err.code, err.message))
end

local function write_buffer()
  vim.b.saving_format = true
  vim.cmd([[
       try
         undojoin | update
       catch /E790/
         update
       endtry
     ]])
  vim.b.saving_format = false
end

local function full_document_result(result)
  return #result == 1 and result[1].range.start.line <= 1
end

-- Add or Remove lines if buffer length differs from result length
local function adjust_buffer_size(current_rows, new_rows, bufnr)
  if current_rows > new_rows then
    vim.api.nvim_buf_set_lines(bufnr, new_rows, -1, false, {})
  elseif current_rows < new_rows then
    vim.api.nvim_buf_set_lines(bufnr, current_rows, new_rows, false, { "" })
  end
end

-- For LSP servers that don't support range-formatting and return the entire buffer every time.
-- Perform a linewise diff of the formatted text and the current buffer text, only updating the
-- lines where the two differ. Prevents needless redrawing/reparsing of buffer.
local function build_range_edits(result, bufnr)
  local text_edits = {}

  local buf_text = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local new_text = vim.split(result[1].newText, "\n", { trimempty = true })

  for line, text in ipairs(new_text) do
    if text ~= buf_text[line] then
      local line_edit = {
        newText = text,
        range = {
          ["start"] = { line = line - 1, character = 0 },
          ["end"] = { line = line - 1, character = buf_text[line] and #buf_text[line] or 0 },
        },
      }

      table.insert(text_edits, line_edit)
    end
  end

  return text_edits, { current_rows = #buf_text, new_rows = #new_text }
end

local function apply_result(result, ctx)
  local text_edits
  local buf_info

  if full_document_result(result) then
    text_edits, buf_info = build_range_edits(result, ctx.bufnr)
    adjust_buffer_size(buf_info.current_rows, buf_info.new_rows, ctx.bufnr)
  else
    text_edits = result
  end

  vim.lsp.util.apply_text_edits(text_edits, ctx.bufnr, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)

  if ctx.bufnr == vim.api.nvim_get_current_buf() then
    write_buffer()
    print("Formatted Buffer")

    -- So Autosave doesn't double save
    vim.api.nvim_buf_set_var(ctx.bufnr, "last_format_changedtick", vim.api.nvim_buf_get_changedtick(ctx.bufnr))
  end
end

local function handler(err, result, ctx)
  if err then
    write_error(err, ctx)
    return
  end

  if abort_formatting(result, ctx.bufnr) then
    return
  end

  -- Having issues with LuaSnip function nodes taking the callback text as input
  if require("luasnip").get_active_snip() then
    require("luasnip").unlink_current()
  end

  local view = vim.fn.winsaveview()
  apply_result(result, ctx)
  vim.fn.winrestview(view)
end

function M.callback(client, bufnr)
  if not vim.b.saving_format then
    vim.b.format_changedtick = vim.api.nvim_buf_get_changedtick(bufnr)
    vim.b.format_curpos      = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
    client.request("textDocument/formatting", vim.lsp.util.make_formatting_params({}), handler, bufnr)
  end
end

return M

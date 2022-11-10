local function cursor_has_moved(bufnr)
  return not vim.deep_equal(vim.api.nvim_win_get_cursor(0), vim.api.nvim_buf_get_var(bufnr, "format_curpos"))
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

local function abort_formatting(result, bufnr)
  return no_result(result) or not_in_normal_mode() or cursor_has_moved(bufnr) or new_changedtick_value(bufnr)
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
  return #result == 1 and result[1].range.start.line == 1
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
    text_edits, buf_info = build_range_edits(result)
    adjust_buffer_size(buf_info.current_rows, buf_info.new_rows, ctx.bufnr)
  else
    text_edits = result
  end

  vim.lsp.util.apply_text_edits(text_edits, ctx.bufnr, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)

  if ctx.bufnr == vim.api.nvim_get_current_buf() then
    write_buffer()
    vim.notify("Formatted Buffer", "info", { hide_from_history = true, timeout = 1000 })

    -- So Autosave doesn't double save
    vim.api.nvim_buf_set_var(ctx.bufnr, "last_format_changedtick", vim.api.nvim_buf_get_changedtick(ctx.bufnr))
  end
end

-- Handler Function
return function(err, result, ctx)
  if err then
    write_error(err, ctx)
    return
  end

  if abort_formatting(result, ctx.bufnr) then
    return
  end

  -- -- Having issues with LuaSnip function nodes taking the callback text as input
  -- if require("luasnip").in_snippet() then
  --   require("luasnip").get_active_snip():exit()
  -- end

  local view = vim.fn.winsaveview()
  apply_result(result, ctx)
  vim.fn.winrestview(view)
end

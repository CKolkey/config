local function safe_require(mod)
  local ok, r = pcall(require, mod)
  if not ok then
    vim.schedule(function()
      error(r)
    end)
  end
end

safe_require("ckolkey.extensions")
safe_require("ckolkey.utils")
safe_require("ckolkey.config.options")
safe_require("ckolkey.config.filetypes")
safe_require("ckolkey.config.plugins")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    safe_require("ckolkey.config.keymaps")
    safe_require("ckolkey.config.autocmds")
    safe_require("ckolkey.config.commands")
    safe_require("ckolkey.config.diagnostics")

    if os.getenv("PROFILE") then
      require("plenary.profile").start("profile.log", { flame = true })
      vim.api.nvim_create_autocmd("VimLeavePre", { callback = require("plenary.profile").stop })
    end

    require "vim._core.ui2".enable({
      enable = true,
      msg = { target = "msg" }
    })

    vim.ui.input = function(opts, on_confirm)
      if on_confirm then
        local prompt = (opts or {}).prompt or "Input: "
        local default = (opts or {}).default or ""

        vim.fn.inputsave()
        local ok, result = pcall(vim.fn.input, vim.tbl_extend("keep", opts, {
          prompt = prompt,
          default = default,
          cancelreturn = vim.NIL,
        }))
        vim.fn.inputrestore()

        if not ok or result == vim.NIL then
          on_confirm(nil)
        else
          on_confirm(result)
        end
      end
    end

    ---@param msg string
    ---@param choices string[]
    ---@return number
    local function select_option(msg, choices)
      local chunks = { { msg .. "\n", "Title" } }
      for i, choice in ipairs(choices) do
        table.insert(chunks, { string.format("  %d. %s\n", i, choice) })
      end

      vim.schedule(function()
        vim.api.nvim_echo(chunks, false, { id = "ui.select" })
      end)

      local char = vim.fn.getcharstr()
      local idx = tonumber(char)

      -- Clear prompt
      vim.api.nvim_echo({ { "" } }, false, { id = "ui.select" })

      if idx and idx >= 1 and idx <= #choices then
        return idx
      else
        return 0
      end
    end

    ---@param items T[]
    ---@param opts { prompt: string?, format_item: fun(any): string? }
    ---@param on_choice fun(item: T?, idx: number?)
    vim.ui.select = function(items, opts, on_choice)
      opts = opts or {}
      opts.format_item = opts.format_item or tostring

      local prompt = opts.prompt or "Select one:"
      local choices = {}
      for _, item in ipairs(items) do
        table.insert(choices, opts.format_item(item))
      end

      local ok, idx = pcall(select_option, prompt, choices)
      if not ok or idx == 0 then
        on_choice(nil, nil)
      else
        on_choice(items[idx], idx)
      end
    end
  end,
})

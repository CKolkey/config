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

    -- vim.ui.select = function(items, opts, on_choice)
    --   opts = opts or {}
    --   local prompt = opts.prompt or "Select one:"
    --   local choices
    --   if type(items) ~= "table" then
    --     choices = table.concat(items, "\n")
    --   else
    --     choices = items
    --   end
    --
    --   local ok, idx = pcall(vim.fn.confirm, prompt, choices)
    --
    --   if not ok or idx == 0 then
    --     on_choice(nil, nil)
    --   else
    --     on_choice(items[idx], idx)
    --   end
    -- end
  end,
})

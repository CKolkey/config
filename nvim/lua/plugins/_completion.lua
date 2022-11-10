local M = {}

local item_format = function(entry, vim_item)
  local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
  local strings = vim.split(kind.kind, "%s", { trimempty = true })
  kind.kind = " " .. strings[1] .. " "
  kind.menu = "    (" .. strings[2] .. ")"

  return kind
end

local cmp = require("cmp")
local luasnip = require("luasnip")
local compare = require("cmp.config.compare")

M.config = function()
  cmp.setup({
    window = {
      documentation = cmp.config.window.bordered(),
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = item_format,
    },

    sorting = {
      priority_weight = 2,
      comparators = {
        compare.score,
        compare.exact,
        compare.recently_used,
        require("cmp_fuzzy_buffer.compare"),
        compare.offset,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ["<c-k>"] = {
        i = function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
          elseif luasnip.expandable() then
            luasnip.expand()
          else
            fallback()
          end
        end,
      },

      ["<c-n>"] = {
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end,
      },

      ["<c-p>"] = {
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
      },

      ["<tab>"] = {
        i = function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end,
      },

      ["<s-tab>"] = {
        i = function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
      },
    }),

    sources = {
      { name = "path", priority_weight = 100 },
      { name = "luasnip", priority_weight = 90, max_item_count = 5 },
      { name = "treesitter", priority_weight = 85, max_item_count = 5 },
      { name = "nvim_lsp", priority_weight = 80, max_item_count = 10 },
      { name = "fuzzy_buffer", priority_weight = 70, max_item_count = 5 },
      { name = "cmp_tabnine", priority_weight = 65 },
      {
        name = "rg",
        priority_weight = 60,
        max_item_count = 5,
        keyword_length = 5,
        option = {
          additional_arguments = "--smart-case",
        },
      },
      { name = "orgmode" },
    },
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "fuzzy_buffer", max_item_count = 15 },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path", max_item_count = 5 },
    }, {
      { name = "cmdline", max_item_count = 10 },
    }),
  })
end

return M

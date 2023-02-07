return {

  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- "tzachar/cmp-tabnine", run = "./install.sh",
    "ray-x/cmp-treesitter",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    { "hrsh7th/cmp-nvim-lsp", opts = {} },
    "hrsh7th/cmp-cmdline",
    "lukas-reineke/cmp-rg",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "onsails/lspkind-nvim",
  },

  config = function()
    local cmp     = require("cmp")
    local luasnip = require("luasnip")
    local compare = require("cmp.config.compare")

    -- Add parens to functions returned from cmp
    cmp.event:on(
      'confirm_done',
      require('nvim-autopairs.completion.cmp').on_confirm_done(
        {
          filetypes = {
            ruby = false,
            ["*"] = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = require('nvim-autopairs.completion.handlers')["*"]
              }
            },
          }
        }
      )
    )

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
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. strings[1] .. " "
          kind.menu = "    (" .. strings[2] .. ")"

          return kind
        end,
      },

      sorting = {
        priority_weight = 2,
        comparators = {
          compare.score,
          compare.exact,
          compare.recently_used,
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
              -- elseif luasnip.jumpable(1) then
              -- luasnip.jump(1)
            else
              fallback()
            end
          end,
        },

        ["<c-e>"] = {
          i = function(fallback)
            if cmp.visible() then
              cmp.close()
            end
            fallback()
          end,
        },

        ["<c-p>"] = {
          i = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              -- elseif luasnip.jumpable(-1) then
              -- luasnip.jump(-1)
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
        { name = "path", priority_weight = 100, max_item_count = 3 },
        { name = "luasnip", priority_weight = 90, max_item_count = 2 },
        { name = "nvim_lsp", priority_weight = 85, max_item_count = 10 },
        { name = "treesitter", priority_weight = 80, max_item_count = 5 },
        {
          name = "rg",
          priority_weight = 60,
          max_item_count = 5,
          keyword_length = 5,
          option = {
            additional_arguments = "--smart-case",
          },
        },
      },
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
      }, {
        { name = 'buffer' }
      })
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path", max_item_count = 5 },
      }, {
        { name = "cmdline", max_item_count = 10 },
      }),
    })
  end,
}

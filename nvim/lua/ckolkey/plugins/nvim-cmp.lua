return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "lukas-reineke/cmp-rg",
    "onsails/lspkind-nvim",
    "ray-x/cmp-treesitter",
    "saadparwaiz1/cmp_luasnip",
    { "hrsh7th/cmp-nvim-lsp", opts = {} },
    { "zbirenbaum/copilot-cmp", opts = {} },
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local compare = require("cmp.config.compare")

    -- Add parens to functions returned from cmp
    cmp.event:on(
      "confirm_done",
      require("nvim-autopairs.completion.cmp").on_confirm_done({
        filetypes = {
          ruby = false,
          ["*"] = {
            ["("] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = require("nvim-autopairs.completion.handlers")["*"],
            },
          },
        },
      })
    )

    cmp.setup({
      window = {
        documentation = cmp.config.window.bordered(),
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -4,
          side_padding = 0,
        },
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "text", maxwidth = 50 })(entry, vim_item)
          kind.menu = "    (" .. kind.kind .. ")"
          kind.kind = " " .. (Icons.lsp_kind[kind.kind] or "XX") .. " "
          return kind
        end,
      },

      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
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
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp_document_symbol" },
        { name = "copilot", group_index = 2 },
        { name = "path", priority_weight = 100, max_item_count = 40 },
        {
          name = "luasnip",
          priority_weight = 90,
          max_item_count = 2,
          option = { use_show_condition = true },
          entry_filter = function()
            local context = require("cmp.config.context")
            return not context.in_treesitter_capture("string")
              and not context.in_syntax_group("String")
              and not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end,
        },
        { name = "nvim_lsp", priority_weight = 85, max_item_count = 50 },
        { name = "treesitter", priority_weight = 80, max_item_count = 5 },
        {
          name = "rg",
          priority_weight = 60,
          max_item_count = 10,
          keyword_length = 5,
          option = {
            additional_arguments = "--smart-case",
          },
        },
      },
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "nvim_lsp_document_symbol" } }, { { name = "buffer" } }),
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        { { name = "path", max_item_count = 20 } },
        { { name = "cmdline", max_item_count = 30 } },
        { { name = "cmdline_history", max_item_count = 10 } }
      ),
    })
  end,
}

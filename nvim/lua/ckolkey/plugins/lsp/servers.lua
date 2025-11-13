local prettierd = {
  formatCommand = "prettierd ${INPUT}",
  formatStdin = true,
  env = { string.format("PRETTIERD_DEFAULT_CONFIG=%s/.prettierrc.json", vim.fn.getcwd()) },
}

return {
  rust_analyzer = {},
  bashls = {},
  typos_lsp = {},
  ctags_lsp = {
    cmd = { "ctags-lsp" },
    filetypes = { "ruby", "python", "lua" },
    root_dir = vim.uv.cwd(),
  },
  basedpyright = {
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        -- disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          -- ignore = { '*' },
        },
      },
    },
  },
  ruff = {
    cmd = { "uv", "run", "ruff", "server" }
  }, -- python linting
  ruby_lsp = {
    init_options = {
      featuresConfiguration = {
        inlayHint = {
          enableAll = true,
        },
      },
    },
  },
  gopls = {},
  efm = {
    init_options = { documentFormatting = true },
    filetypes = {
      "yaml",
      "lua",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      rootMarkers = { ".git/" },
      languages = {
        ["yaml"] = {
          -- {
          --   formatCommand = "yamlfmt -in ${INPUT}",
          --   formatStdin = true,
          -- },
          {
            lintCommand = "yamllint -f parsable -",
            lintStdin = true,
            -- lintIgnoreExitCode = true
          },
        },
        -- ["lua"] = {
        --   {
        --     formatCommand = "stylua --color Never -",
        --     formatStdin = true,
        --     rootMarkers = { "stylua.toml", ".stylua.toml" },
        --   },
        -- },
        ["javascript"] = { prettierd },
        ["javascriptreact"] = { prettierd },
        ["javascript.jsx"] = { prettierd },
        ["typescript"] = { prettierd },
        ["typescriptreact"] = { prettierd },
        ["typescript.tsx"] = { prettierd },
      },
    },
  },
  ts_ls = {
    init_options = {
      documentFormatting = false,
      hostInfo = "neovim",
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            quote_style = "AutoPreferDouble",
            call_parentheses = "Always",
            column_width = "120",
            line_endings = "Unix",
          },
        },
        hint = {
          enable = true,
          setType = true,
        },
        diagnostics = {
          enable = true,
          neededFileStatus = {
            ["codestyle-check"] = "Any",
          },
          globals = { "vim", "hs" },
        },
        workspace = {
          checkThirdParty = true,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

local solargraph_cmd = function()
  if utils.file_in_cwd(".solargraph.yml") then
    if utils.file_in_cwd("bin/bundle") then
      return { vim.loop.cwd() .. "/bin/bundle", "exec", "solargraph", "stdio" }
    else
      return { "bundle", "exec", "solargraph", "stdio" }
    end
  else
    return { "solargraph", "stdio" }
  end
end

local prettierd = {
  formatCommand = "prettierd ${INPUT}",
  formatStdin = true,
  env = { string.format("PRETTIERD_DEFAULT_CONFIG=%s/.prettierrc.json", vim.fn.getcwd()) },
}

return {
  rust_analyzer = {},
  bashls = {},
  solargraph = {
    -- cmd = { "nc", "127.0.0.1", "7658" },
    cmd = solargraph_cmd(),
  },
  efm = {
    init_options = { documentFormatting = true },
    filetypes = {
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
        ["lua"] = {
          {
            formatCommand = "stylua --color Never -",
            formatStdin = true,
            rootMarkers = { "stylua.toml", ".stylua.toml" },
          },
        },
        ["javascript"] = { prettierd },
        ["javascriptreact"] = { prettierd },
        ["javascript.jsx"] = { prettierd },
        ["typescript"] = { prettierd },
        ["typescriptreact"] = { prettierd },
        ["typescript.tsx"] = { prettierd },
      },
    },
  },
  tsserver = {
    init_options = {
      documentFormatting = false,
      hostInfo = "neovim",
    },
  },
  lua_ls = {
    init_options = { documentFormatting = false },
    settings = {
      Lua = {
        runtime = {
          version = "Lua 5.1",
          -- path = {
          --   '?.lua',
          --   '?/init.lua',
          -- }
        },
        format = {
          enable = false,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            quote_style = "AutoPreferDouble",
            call_parentheses = "Always",
            column_width = "120",
            line_endings = "Unix",
          },
        },
        diagnostics = {
          enable = true,
          neededFileStatus = {
            ["codestyle-check"] = "Any",
          },
          globals = { "vim", "hs" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

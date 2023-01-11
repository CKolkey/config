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

return {
  solargraph = {
    -- cmd = { "nc", "127.0.0.1", "7658" },
    cmd = solargraph_cmd()
  },
  tsserver = {},
  sumneko_lua = {
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
  }
}

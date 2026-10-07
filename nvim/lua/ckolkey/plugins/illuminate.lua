local IDENTIFIER = "identifier"

return {
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure({
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
        'NeogitStatus',
      },
      -- should_enable = function()
      --   local node = vim.treesitter.get_node({ ignore_injections = false })
      --   if node then
      --     local node_type = node:type()
      --     return (node_type:match(".*variable.*") or node_type == IDENTIFIER)
      --   else
      --     return false
      --   end
      -- end
    })
  end
}

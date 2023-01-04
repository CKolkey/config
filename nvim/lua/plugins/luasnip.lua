return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    require("luasnip").config.set_config({
      enable_autosnippets = true,
      history = true,
      updateevents = "TextChanged,TextChangedI",
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "<-", "Error" } },
          },
        },
      },
    })
  end,
}

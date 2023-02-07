local M = {}

M.snippets = {
  ["if"] = {
    description = "If Block",
    "<% if ",
    i(1),
    " %>",
    indent(),
    i(0),
    newline("<% end %>"),
  },
  ["ifel"] = {
    description = "If/else Block",
    "<% if ",
    i(1),
    " %>",
    indent(),
    i(2),
    newline("<% else %>"),
    indent(),
    i(0),
    newline("<% end %>"),
  },
  ["else"] = {
    description = "Inline Else",
    "<% else %>",
  },
  ["end"] = {
    description = "Inline end",
    "<% end %>",
  },
  ["="] = {
    description = "Render Output",
    "<%= ",
    i(0),
    " %>",
  },
  ["-"] = {
    description = "Embedded Ruby",
    "<% ",
    i(0),
    " %>",
  },
}

M.autosnippets = {
  ["<"] = {
    description = "Auto Tag",
    "<",
    i(1),
    ">",
    i(0),
    f(function(args)
      local last_char = string.sub(args[1][1], #args[1][1])
      if last_char == "/" then
        return ""
      else
        return "</" .. utils.strip(args[1][1], { "%s+.*" }) .. ">"
      end
    end, 1),
  },
}

return M

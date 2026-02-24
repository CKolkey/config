return {
  "dariuscorvus/tree-sitter-language-injection.nvim",
  opts = {
    python = {
      comment = {
        langs = {
          { name = "lua", match = "^#+( )*{lang}( )*" },
        },
        query = [[
; query
;; comment {name} injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "{match}")
                           (#set! injection.language "{name}")))))
]],
      },
    },
  },
}

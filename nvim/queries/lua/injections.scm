; extends

; Matches ("%d"):format(value)
(function_call
  (method_index_expression
    table: (parenthesized_expression (string content: _ @injection.content) (#set! injection.language "luap"))
    method: (identifier) @_method))

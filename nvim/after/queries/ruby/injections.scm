;extends

(heredoc_body
  (heredoc_content) @injection.content
  (heredoc_end) @language (#eq? @language "ERB")
  (#set! injection.language "embedded_template")
)

;extends

; query
;; string sql injection
((string_content) @injection.content 
                   (#match? @injection.content "^(\r\n|\r|\n)*-{2,}( )*[sS][qQ][lL]")
                   (#set! injection.language "sql"))

; query
;; string javascript injection
((string_content) @injection.content 
                   (#match? @injection.content "^(\r\n|\r|\n)*/{2,}( )*[jJ][aA][vV][aA][sS][cC][rR][iI][pP][tT]")
                   (#set! injection.language "javascript"))

; query
;; string typescript injection
((string_content) @injection.content 
                   (#match? @injection.content "^(\r\n|\r|\n)//+( )*[tT][yY][pP][eE][sS][cC][rR][iI][pP][tT]")
                   (#set! injection.language "typescript"))

; query
;; string html injection
((string_content) @injection.content 
                   (#match? @injection.content "^(\r\n|\r|\n)\\<\\!-{2,}( )*[hH][tT][mM][lL]( )*-{2,}\\>")
                   (#set! injection.language "html"))

; query
;; string css injection
((string_content) @injection.content 
                   (#match? @injection.content "^(\r\n|\r|\n)/\\*+( )*[cC][sS][sS]( )*\\*+/")
                   (#set! injection.language "css"))

; query
;; string python injection
((string_content) @injection.content 
                   (#match? @injection.content "^(\r\n|\r|\n)*#+( )*[pP][yY][tT][hH][oO][nN]")
                   (#set! injection.language "python"))

; query
;; comment javascript injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "^#+( )*[jJ][aA][vV][aA][sS][cC][rR][iI][pP][tT]( )*")
                           (#set! injection.language "javascript")))))

; query
;; comment sql injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "^#+( )*[sS][qQ][lL]( )*")
                           (#set! injection.language "sql")))))

; query
;; comment css injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "^#+( )*[cC][sS][sS]( )*")
                           (#set! injection.language "css")))))

; query
;; comment typescript injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "^#+( )*[tT][yY][pP][eE][sS][cC][rR][iI][pP][tT]( )*")
                           (#set! injection.language "typescript")))))

; query
;; comment html injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "^#+( )*[hH][tT][mM][lL]( )*")
                           (#set! injection.language "html")))))

; query
;; comment python injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "^#+( )*[pP][yY][tT][hH][oO][nN]( )*")
                           (#set! injection.language "python")))))

; query
;; comment lua injection
((comment) @comment .
           (expression_statement
             (assignment right:
                         (string
                           (string_content)
                           @injection.content
                           (#match? @comment "^#+( )*[lL][uU][aA]( )*")
                           (#set! injection.language "lua")))))

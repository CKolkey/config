;extends

; query
;; comment sql injection
((line_comment) 
 @comment .
 (let_declaration 
   value: 
   (raw_string_literal
     (string_content) 
     @injection.content)
    )
  (#match? @comment "^//+( )*[sS][qQ][lL]( )*")
  (#set! injection.language "sql")
  )
        
; query
;; comment javascript injection
((line_comment) 
 @comment .
 (let_declaration 
   value: 
   (raw_string_literal
     (string_content) 
     @injection.content)
    )
  (#match? @comment "^//+( )*[jJ][aA][vV][aA][sS][cC][rR][iI][pP][tT]( )*")
  (#set! injection.language "javascript")
  )
        
; query
;; comment typescript injection
((line_comment) 
 @comment .
 (let_declaration 
   value: 
   (raw_string_literal
     (string_content) 
     @injection.content)
    )
  (#match? @comment "^//+( )*[tT][yY][pP][eE][sS][cC][rR][iI][pP][tT]( )*")
  (#set! injection.language "typescript")
  )
        
; query
;; comment html injection
((line_comment) 
 @comment .
 (let_declaration 
   value: 
   (raw_string_literal
     (string_content) 
     @injection.content)
    )
  (#match? @comment "^//+( )*[hH][tT][mM][lL]( )*")
  (#set! injection.language "html")
  )
        
; query
;; comment css injection
((line_comment) 
 @comment .
 (let_declaration 
   value: 
   (raw_string_literal
     (string_content) 
     @injection.content)
    )
  (#match? @comment "^//+( )*[cC][sS][sS]( )*")
  (#set! injection.language "css")
  )
        
; query
;; comment python injection
((line_comment) 
 @comment .
 (let_declaration 
   value: 
   (raw_string_literal
     (string_content) 
     @injection.content)
    )
  (#match? @comment "^//+( )*[pP][yY][tT][hH][oO][nN]( )*")
  (#set! injection.language "python")
  )
        
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
        
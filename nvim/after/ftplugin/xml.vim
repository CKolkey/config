setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
" exe ":silent %!xmllint --format --recover - 2>/dev/null" | silent update

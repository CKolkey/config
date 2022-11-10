function rg-fzf
  set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case --pcre2 "

  FZF_DEFAULT_COMMAND="$RG_PREFIX ''" \
    fzf --bind "change:reload:$RG_PREFIX -e {q} $argv || true" \
        --bind "esc:print-query+abort" \
        --ansi --disabled --print-query
end

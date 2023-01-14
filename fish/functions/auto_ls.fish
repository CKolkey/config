function auto_ls --on-variable PWD
  echo
  exa --sort name --all --icons --classify --group-directories-first --ignore-glob=.DS_Store
end

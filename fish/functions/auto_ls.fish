function auto_ls --on-variable PWD
  echo
  eza --sort name --all --icons --classify --group-directories-first --ignore-glob=.DS_Store
end

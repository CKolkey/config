function asdf-direnv-hook --on-variable PWD
  if test -e ./.envrc
    asdf direnv local
  end
end

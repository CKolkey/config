function __fish_jin_commands
  jin commands
end

function __fish_jin_completions
  set cmd (commandline -opc)
  jin completions $cmd[2]
end

function __fish_jin_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  end
  return 1
end

function __fish_jin_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    return 0
  end
  return 1
end

complete -f -c jin -n '__fish_jin_needs_command' -a '(__fish_jin_commands)'
complete -f -c jin -n '__fish_jin_using_command' -a '(__fish_jin_completions)'

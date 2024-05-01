# Interactive CD if not argument is passed. Normal CD if arg is passed.
function cd
  set origin "$(pwd)"

  if count $argv > /dev/null
    if [ "$argv" = "-" ]
      # When passing "-" as the arg, go to previous CWD
      builtin cd "$PREV_CWD"
    else
      # Standard cd behaviour
      builtin cd "$argv"
    end
  else
    # Interactive, fzf backed, cd
    set path

    while true
      set dir "$(ls -a1p "./$path" | grep '/$' | grep -v '^./$' | fzf --color=pointer:#a377bf,prompt:#c792ea --height 40% --reverse --no-multi --no-info --prompt "$(realpath $origin/$path)/")"

      if test -z "$dir"
        break
      else
        set path "$path$dir"
      end
    end

    builtin cd "$origin/$path"

    commandline -t "" # Remove last token from commandline.
    commandline -f repaint
  end

  set -g -x PREV_CWD "$origin"
end

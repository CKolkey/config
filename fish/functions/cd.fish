# Interactive CD if not argument is passed. Normal CD if arg is passed.
function cd
  if count $argv > /dev/null
    builtin cd "$argv"
  else
    set origin "$(pwd)"
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
  end
end

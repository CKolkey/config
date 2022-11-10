# CD + FZF = cd-i(nteractive)
function cdi
  set origin "$(pwd)"
  set path

  while true
    echo -n "$origin/$path"
    set dir "$(ls -a1p "./$path" | grep '/$' | grep -v '^./$' | fzf --height 40% --reverse --no-multi --no-info)"

    if test -z "$dir"
      break
    else
      set path "$path$dir"
    end
  end

  cd "$origin/$path"
end

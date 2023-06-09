# Lists processes currently listening on a port, and provides interface for interactively killing the process
function unbind
  lsof -nP -i4TCP | rg LISTEN | awk '{ print $2,$1,$9 }' | column -t | fzf | awk '{ print $1 }' | xargs kill -9
end

if type -q zellij
  # Update the zellij tab name with the current process name or pwd.
  function zellij_tab_name_update_pre --on-event fish_preexec
    if set -q ZELLIJ
      set -l cmd_line (string split " " -- $argv)
      set -l process_name $cmd_line[1]
      if test -n "$process_name" -a "$process_name" != "z"
        command nohup zellij action rename-tab $process_name >/dev/null 2>&1
      end
    end
  end

  # Restore tab title to PWD after command exits
  function zellij_tab_name_update_post --on-event fish_postexec
    if set -q ZELLIJ
      zellij_tab_name_update
    end
  end

  function zellij_tab_name_update --on-variable PWD
    if set -q ZELLIJ
      set tab_name ''
      if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set git_root (basename (git rev-parse --show-toplevel))
        set git_prefix (git rev-parse --show-prefix)
        set tab_name "$git_root/$git_prefix"
        set tab_name (string trim -c / "$tab_name") # Remove trailing slash
      else
        set tab_name $PWD
        if test "$tab_name" = "$HOME"
          set tab_name "~"
        else
          set tab_name (basename "$tab_name")
        end
      end
      command nohup zellij action rename-tab $tab_name >/dev/null 2>&1 &
    end
  end
end

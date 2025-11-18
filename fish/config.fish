set -gx XDG_CONFIG_HOME $HOME/.config/

# Work
if test -e "$HOME/work/karnov/jin"
  # eval "$($HOME/work/karnov/jin/bin/jin init -)"
  fish_add_path -g $HOME/work/karnov/jin/bin
  source $HOME/work/karnov/jin/completions/jin.fish
end

fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/.pyenv/bin
fish_add_path -g $HOME/.cargo/bin
fish_add_path -g $HOME/.yarn/bin
fish_add_path -g /usr/local/opt/curl/bin
fish_add_path -g $HOME/.config/git/bin
fish_add_path -g $HOME/.config/emacs/bin
fish_add_path /opt/homebrew/opt/postgresql@16/bin

fish_add_path /opt/homebrew/opt/curl/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/curl/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/curl/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/curl/lib/pkgconfig"

source_homebrew

if status is-interactive
  auto_ls
  direnv hook fish | source
  mise activate fish | source
  starship init fish | source
  fzf --fish | source
  gh completion -s fish | source

  source $HOME/.config/fish/abbreviations.fish
end

set -gx MANPAGER "nvim +Man!"
set -gx GPG_TTY (tty)

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Update zellij tab titles
if status is-interactive
  if [ "$TERM" = "xterm-ghostty" ]
    eval (zellij setup --generate-auto-start fish | string collect)
  end

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
end

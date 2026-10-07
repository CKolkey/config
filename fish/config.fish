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
# fish_add_path /opt/homebrew/opt/postgresql@16/bin

fish_add_path /opt/homebrew/opt/curl/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/curl/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/curl/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/curl/lib/pkgconfig"


if status is-interactive
  cat "$GHOSTTY_RESOURCES_DIR"/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish | source
  __hvst_once_per_day
  source $HOME/.config/fish/abbreviations.fish

  auto_ls
  direnv hook fish | source

  starship init fish | source

  fzf --fish | source
  gh completion -s fish | source
  mise activate fish | source

  if [ "$TERM" = "xterm-ghostty" ]
    set ZELLIJ_AUTO_EXIT true
    eval (zellij setup --generate-auto-start fish | string collect)
  end
end

source_homebrew

set -gx MANPAGER "nvim +Man!"
set -gx GPG_TTY (tty)

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

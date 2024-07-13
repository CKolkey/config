set -gx XDG_CONFIG_HOME $HOME/.config/

# Work
if test -e "$HOME/code/karnov/jin"
  # eval "$($HOME/code/karnov/jin/bin/jin init -)"
  fish_add_path -g $HOME/code/karnov/jin/bin
  eval "$($HOME/code/karnov/db_tonic/bin/init)"
end

fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/.pyenv/bin
fish_add_path -g $HOME/.cargo/bin
fish_add_path -g $HOME/.yarn/bin
fish_add_path -g /usr/local/opt/curl/bin
fish_add_path -g $HOME/.config/git/bin
fish_add_path -g $HOME/.config/emacs/bin
fish_add_path /opt/homebrew/opt/postgresql@16/bin

# asdf_add_path
source_homebrew

if status is-interactive
  auto_ls
  direnv-hook
  mise activate fish | source
  starship init fish | source
  fzf --fish | source

  source $HOME/.config/fish/abbreviations.fish
end

set -gx GPG_TTY (tty)

# pnpm
# set -gx PNPM_HOME "/Users/cameron/Library/pnpm"
# if not string match -q -- $PNPM_HOME $PATH
#   set -gx PATH "$PNPM_HOME" $PATH
# end
# pnpm end


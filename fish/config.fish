set -gx XDG_CONFIG_HOME $HOME/.config/

# Work
fish_add_path -g $HOME/code/karnov/jin/bin

fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/.pyenv/bin
fish_add_path -g $HOME/.cargo/bin
fish_add_path -g $HOME/.yarn/bin
fish_add_path -g /usr/local/opt/curl/bin
fish_add_path -g $HOME/.config/git/bin
fish_add_path -g $HOME/.config/emacs/bin

asdf_add_path
source_homebrew

if status is-interactive
  set -U FZF_COMPLETE 0

  auto_ls
  direnv-hook
  asdf-install-hook
  # rtx activate fish | source
  starship init fish | source
  # source "$HOMEBREW_PREFIX/share/google-cloud-sdk/path.fish.inc"
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

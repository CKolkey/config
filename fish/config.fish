set -gx XDG_CONFIG_HOME $HOME/.config/

fish_add_path -g $HOME/code/karnov/jin/bin
fish_add_path -g $HOME/code/google-cloud-sdk/bin

fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/.pyenv/bin
fish_add_path -g $HOME/.composer/vendor/bin
fish_add_path -g $HOME/.cargo/bin
fish_add_path -g $HOME/.yarn/bin
fish_add_path -g /usr/local/opt/curl/bin
fish_add_path -g $HOME/.config/git/bin

if status is-interactive
  auto_ls
  direnv-hook

  atuin init fish | source
  starship init fish | source
end

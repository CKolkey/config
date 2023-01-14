set -gx XDG_CONFIG_HOME $HOME/.config/

fish_add_path -g $HOME/code/karnov/jin/bin
fish_add_path -g $HOME/code/google-cloud-sdk/bin

fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/.pyenv/bin
fish_add_path -g $HOME/.cargo/bin
fish_add_path -g $HOME/.yarn/bin
fish_add_path -g /usr/local/opt/curl/bin
fish_add_path -g $HOME/.config/git/bin

asdf_add_path
source_homebrew

if status is-interactive
  # alias -s ls 'exa --color=always --icons --group-directories-first'
  # alias -s la 'exa --color=always --icons --group-directories-first --all'
  # alias -s ll 'exa --color=always --icons --group-directories-first --all --long'
  set -U FZF_COMPLETE 0

  auto_ls
  direnv-hook
  asdf-install-hook

  # atuin init fish | source
  starship init fish | source
end

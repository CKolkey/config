function rubocop_quickfix --description "Runs rubocop and loads neovim with quickfix. Arg can be specified for a specific infraction"
  if count $argv > /dev/null
    bundle exec rubocop | rg "$argv" > /tmp/rubocop && nvim -q /tmp/rubocop
  else
    bundle exec rubocop | rg "\.rb:\d+:\d+: [ECW]: " > /tmp/rubocop && nvim -q /tmp/rubocop
  end
end

function source_homebrew
  set -gx HOMEBREW_NO_ENV_HINTS 1

  if string match --quiet --entire "arm64" (arch)
    /opt/homebrew/bin/brew shellenv | source
  else
    /usr/local/bin/brew shellenv | source
  end
end

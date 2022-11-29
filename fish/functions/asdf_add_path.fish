function asdf_add_path
  set -l asdf_bin_dirs "/usr/local/opt/asdf/libexec/bin" "$HOME/.asdf/shims"
  for x in $asdf_bin_dirs
    if test -d $x
      fish_add_path -g $x
    end
  end
end

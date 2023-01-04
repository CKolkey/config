# Prompt to install any missing tools when entering git repo
function asdf-install-hook --on-event fish_prompt
  if not test -d ".git/"
    return
  end

  set -l plugin_path "$HOME/.asdf/plugins"
  for plugin in (ls $plugin_path)
    set -l plugin_bin "$plugin_path/$plugin/bin"

    if test -e "$plugin_bin/list-legacy-filenames"
      for file in (string split " " ("$plugin_bin/list-legacy-filenames"))
        if test -e $file
          set -l plugin_version ("$plugin_bin/parse-legacy-file" $file)

          if not test -d "$HOME/.asdf/installs/$plugin/$plugin_version"
            if read_confirm "Install $plugin $plugin_version?"
              asdf install $plugin $plugin_version
            end
          # else
          #   asdf direnv local $plugin $plugin_version
          end

          break
        end
      end
    end
  end
end

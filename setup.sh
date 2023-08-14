#!/usr/bin/env bash

if ! command -v brew &> /dev/null
then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# eval brew to add to path
brew install gh
echo "Logging in with Github"
gh auth login

echo "Installing Brew Bundle"
brew bundle --file="./Brewfile"

echo "Using fish shell"
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

echo "Setting up asdf"
asdf plugin list all
asdf plugin-add direnv
asdf direnv setup --shell fish --version system

echo "Installing language servers for JS"
yarn global add vscode-langservers-extracted typescript-language-server typescript


echo "Applying config settings"
git config --global core.excludesFile '~/.config/git/ignore'

bash defaults.osx

# if [[ ! -d "${HOME}/.config" ]]; then
  # mkdir ~/.config
  ln -s ~/.config/hammerspoon/ ~/.hammerspoon
  ln -s ~/.config/asdf/config ~/.asdfrc
  ln -s ~/.config/rdbg/rdbgrc.rb ~/.rdbgrc.rb
  ln -s ~/.config/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
# fi

echo "Install: https://github.com/KoffeinFlummi/htop-vim"

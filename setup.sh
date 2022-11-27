#!/usr/bin/env bash

BREWFILE=$(pwd)/Brewfile
cd ~

if ! command -v brew &> /dev/null
then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install gh
echo "Logging in with Github"
gh auth login

echo "Installing Brew Bundle"
brew bundle --file=$(echo $BREWFILE)

echo "Installing language servers for JS"
yarn global add vscode-langservers-extracted typescript-language-server typescript

echo "Using fish shell"
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

echo "Applying config settings"
git config --global core.excludesFile '~/.config/git/ignore'

bash defaults.osx

if [[ ! -d "~/.config" ]]; then
  mkdir ~/.config
  ln -s ~/.config/hammerspoon/ ~/.hammerspoon
fi

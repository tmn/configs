#!/bin/sh
echo Install all AppStore and XCode at first!
read -p "Press any key to continue..." -n1 -s
echo '\n'

echo Updates brew
brew update
brew upgrade

echo Install essentials

brew install wget
brew install zsh
brew install git
brew install emacs
brew install node
brew install tmux
brew install mosh

brew cleanup

#!/bin/sh
echo Install all AppStore and XCode at first!
read -p "Press any key to continue..." -n1 -s
echo '\n'

echo Updates brew
brew update
brew upgrade --all


echo Install essentials
brew install wget
brew install zsh
brew install git
brew install emacs
brew install node
brew install tmux
brew install mosh


echo tap caskroom/task
brew tap caskroom/cask

echo Install brew cask stuff
brew cask install atom
brew cask install skype
brew cask install omnifocus
brew cask install slack
brew cask install github
brew cask install iterm2
brew cask install vagrant
brew cask install virtualbox
brew cask install iterm2
brew cask install dropbox

brew cleanup

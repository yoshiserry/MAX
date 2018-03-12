#!/usr/bin/env bash

#set defaults for files in finder and dock settings
defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.dock tilesize -int 36; # smaller icon sizes in Dock
defaults write com.apple.dock autohide -bool true; # turn Dock auto-hidng on
defaults write com.apple.dock autohide-delay -float 0; # remove Dock show delay
defaults write com.apple.dock autohide-time-modifier -float 0; # remove Dock show delay
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
killall Dock 2>/dev/null;
killall Finder 2>/dev/null;

#install Xcode Command Line Tools

#curl -fsSL "https://raw.githubusercontent.com/timsutton/osx-vm-templates/master/scripts/xcode-cli-tools.sh" | pbcopy | pbpaste > /Users/joshua/Documents/xcodetools.sh;
sh -c "($ curl -fsSL https://raw.githubusercontent.com/timsutton/osx-vm-templates/master/scripts/xcode-cli-tools.sh)";

sh xcodetools.sh;

touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;

PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
  softwareupdate -i "$PROD" -v;

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
brew install git;
brew install zsh zsh-completions;
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
brew tap caskroom/versions;
brew cask install atom;
brew cask install keka;
brew cask install keepassxc;
brew cask install ccleaner;
brew cask install caret;
brew cask install mpv;
brew cask install cyberduck;
brew cask install dropbox;
brew cask install firefox;
brew cask install google-chrome;
brew cask install spectacle;
brew cask install vlc;
brew cask install telegram;
brew cask install evernote;
brew cask install simplenote;
brew cask install flux;
brew cask install android-file-transfer;
brew cask install androidtool;
brew cask install teamviewer;
brew cask install raindropio;
brew cask install ticktick;
brew cask install insomniax;
chsh -s /usr/local/bin/zsh;
echo "installation complete!";

#installation of ZSH themes
#1. https://github.com/wesbos/Cobalt2-iterm https://www.youtube.com/watch?v=XSeO6nnlWHw
#2. https://github.com/bhilburn/powerlevel9k

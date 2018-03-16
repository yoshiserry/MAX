#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

#set defaults for files in finder and dock settings
echo "Setting finder defaults"
defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.dock tilesize -int 36; # smaller icon sizes in Dock
defaults write com.apple.dock autohide -bool true; # turn Dock auto-hidng on
defaults write com.apple.dock autohide-delay -float 0; # remove Dock show delay
defaults write com.apple.dock autohide-time-modifier -float 0; # remove Dock show delay
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # Show filename extensions by default

killall Dock 2>/dev/null; #kill dock
killall Finder 2>/dev/null;#kill finder

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true; #expand save panel
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true; #expand save panel
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true; #expand save panel

#echo "Never go into computer sleep mode"
#systemsetup -setcomputersleep Off > /dev/null

#install Xcode Command Line Tools
echo "Install xcode command line tools from github"

sh -c "($ curl -fsSL https://raw.githubusercontent.com/timsutton/osx-vm-templates/master/scripts/xcode-cli-tools.sh)";
sh xcodetools.sh;
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;

PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
  softwareupdate -i "$PROD" -v;

  #install Homebrew
  echo "Install Homebrew package manager for osx"

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
brew doctor && brew cask cleanup && brew update-reset && brew update;

echo "prepare installation of homebrew apps..."

brew tap homebrew/dupes;

#coreutils
#gnu-sed --with-default-names
#gnu-tar --with-default-names
#gnu-indent --with-default-names
#gnu-which --with-default-names
#gnu-grep --with-default-names

BREW=(
bash
git
zsh
zsh-completions
)

echo "Installing brew apps..."
brew install ${BREW[@]}

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

#https://github.com/caskroom/homebrew-versions
echo "installing support for alternate versions of Casks E.g. iterm2-beta"
brew tap caskroom/versions;
brew doctor && brew cask cleanup && brew update-reset && brew update;

echo "prepare installation of Cask apps..."

CASKS=(
atom
keka
keepassxc
ccleaner
caret
mpv
cyberduck
dropbox
firefox
google-chrome
spectacle
vlc
telegram
evernote
simplenote
flux
android-file-transfer
androidtool
teamviewer
raindropio
ticktick
insomniax
gitkraken
iterm2
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Cleaning up homebrew and cask..."
brew doctor && brew cask cleanup && brew update-reset && brew update;

echo "Installing anaconda..."
brew cask install anaconda

echo "Cleaning up homebrew and cask..."
brew doctor && brew cask cleanup && brew update-reset && brew update;

echo "Changing SHELL to Zsh..."
chsh -s /usr/local/bin/zsh;

echo "Bootstrap of OSX package installation from Github; Homebrew and Cask is now complete!"

#!/bin/sh

echo "Setting up Mac..."

mkdir -p "$HOME/.config"

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists)
rm -rf $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew tap homebrew/cask-fonts
brew bundle --file ./Brewfile


# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi


# Install zsh plugins

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

## plugins & themes auto-updater
if [ ! -d "${ZSH_CUSTOM}/plugins/ohmyzsh-full-autoupdate" ] ; then
  git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM}/plugins/ohmyzsh-full-autoupdate || exit 1
else
  cd "${ZSH_CUSTOM}/plugins/ohmyzsh-full-autoupdate" || exit 1
  git pull https://github.com/Pilaton/OhMyZsh-full-autoupdate.git || exit 1
fi

## powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ] ; then
  git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k || exit 1
else
  cd "${ZSH_CUSTOM}/themes/powerlevel10k" || exit 1
  git pull https://github.com/romkatv/powerlevel10k.git || exit 1
fi

## zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ] ; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting || exit 1
else
  cd "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" || exit 1
  git pull https://github.com/zsh-users/zsh-syntax-highlighting.git || exit 1
fi

## zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ] ; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM}/plugins/zsh-autosuggestions || exit 1
else
  cd "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" || exit 1
  git pull https://github.com/zsh-users/zsh-autosuggestions.git || exit 1
fi


echo "Setup configs via stow"
cd $HOME/.dotfiles
stow zsh
stow vim
stow git

echo "Change to home then confirm"
cd
ls -la

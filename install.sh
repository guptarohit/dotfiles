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
install_plugins() {
  ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
  type=$1
  name=$2
  repo=$3

  if [ "$type" = "theme" ]; then
    plugin_path=$ZSH_CUSTOM/themes
  elif [ "$type" = "plugin" ]; then
    plugin_path=$ZSH_CUSTOM/plugins
  else
    echo "Invalid type: $type"
    return 1
  fi

  plugin_path=$plugin_path/$name

  if [ ! -d "$plugin_path" ]; then
    git clone "$repo" "$plugin_path" || exit 1
  else
    cd "$plugin_path" && git pull "$repo" || exit 1
  fi
}

install_plugins theme powerlevel10k https://github.com/romkatv/powerlevel10k.git
install_plugins plugin ohmyzsh-full-autoupdate https://github.com/Pilaton/OhMyZsh-full-autoupdate.git
install_plugins plugin you-should-use https://github.com/MichaelAquilina/zsh-you-should-use.git
install_plugins plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
install_plugins plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git

echo "Setup configs via stow"
cd $HOME/.dotfiles || exit 1
stow zsh
stow vim
stow git

echo "Change to home then confirm"
cd
ls -la
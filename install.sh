#!/bin/sh
set -euo pipefail

echo "Setting up Mac..."

mkdir -p "$HOME/.config"

# Check for Homebrew and install if we don't have it
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Backup existing .zshrc if present
if [ -f "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
  echo "Backed up ~/.zshrc to ~/.zshrc.bak"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Check for Oh My Zsh and install if we don't have it
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

clone_or_pull(){
  repo_url=$1
  directory=$2

  if [ ! -d "$directory" ]; then
    git clone "$repo_url" "$directory" || exit 1
  else
    cd "$directory" && git pull "$repo_url" || exit 1
  fi
}


# Install zsh plugins
install_plugins() {
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
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

  clone_or_pull "$repo" "$plugin_path"
}

install_plugins theme powerlevel10k https://github.com/romkatv/powerlevel10k.git
install_plugins plugin ohmyzsh-full-autoupdate https://github.com/Pilaton/OhMyZsh-full-autoupdate.git
install_plugins plugin you-should-use https://github.com/MichaelAquilina/zsh-you-should-use.git
install_plugins plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
install_plugins plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git

# Install fzf-tab (not an OMZ plugin, but installed to OMZ custom plugins dir)
install_plugins plugin fzf-tab https://github.com/Aloxaf/fzf-tab.git

echo "Setup configs via stow"
cd "$HOME/.dotfiles" || exit 1
stow stow
stow zsh
stow tmux
stow vim
stow git
stow fd
stow bat
stow iterm2
stow lazygit
stow fastfetch
stow atuin
stow --adopt agents

# Symlink Claude Code skills to shared agent skills directory
mkdir -p ~/.claude
if [ -d ~/.claude/skills ] && [ ! -L ~/.claude/skills ]; then
  mv ~/.claude/skills ~/.claude/skills.bak
fi
ln -sfn ~/.agents/skills ~/.claude/skills
if [ -d ~/.claude/skills.bak ]; then
  rsync -a ~/.claude/skills.bak/ ~/.agents/skills/
  rm -rf ~/.claude/skills.bak
fi

echo "Setting up iTerm2 preferences..."

if [ -d "/Applications/iTerm.app" ]; then
  # Specify the preferences directory
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2_settings"

  # Tell iTerm2 to use the custom preferences in the directory
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

  # Tell iTerm2 to save preferences automatically
  defaults write com.googlecode.iterm2.plist "NoSyncNeverRemindPrefsChangesLostForFile_selection" -int 2
fi

echo "Installing tmux plugins manager..."
clone_or_pull https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install vim plugins
echo "Installing vim plugins..."
vim +PlugInstall +qall

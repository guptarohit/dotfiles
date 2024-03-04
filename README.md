# dotfiles

These dotfiles are from my primary setup, the core of which includes: macOS, [iTerm2](https://iterm2.com/), and the zsh shell.
Symlinks are managed with the [Stow](https://www.gnu.org/software/stow/).

![Screenshot](./.github/images/setup_screenshot.png)


## Installation
To set up, assuming `git` is installed, run:

```bash
git clone https://github.com/guptarohit/dotfiles.git ~/.dotfiles
cd $HOME/.dotfiles
bash install.sh
```

## Usage
To create symlinks, use stow. The following command will create symlinks for gnupg configs.
```bash
stow gnupg
```

Please note, if files are already present in the directory we are trying to create a stow in, then use the `--adopt` flag.
e.g.
```bash
stow gnupg --adopt
```


## Local configs

### zsh
System specific shell configs can be added to `~/.zshrc.local`. These will be sourced when the shell initializes.

### Git
System specific git configs like user's name, email, signingkey, etc. can be added to `~/.gitconfig.local`.

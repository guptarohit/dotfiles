#!/bin/bash

# add rust path
export PATH="$HOME/.cargo/bin:$PATH"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# golang paths
export GOPATH=$HOME/GolandProjects
export PATH="$GOPATH/bin:$PATH"

export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

#GPG specifics
GPG_TTY=$(tty)
export GPG_TTY

export PATH="$HOME/.local/bin:$PATH"

export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="false"
ENABLE_CORRECTION="true"
HIST_STAMPS="mm/dd/yyyy"

zstyle ':omz:update' mode reminder  # :auto; disabled; reminder
zstyle ':omz:update' frequency 15

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	ohmyzsh-full-autoupdate
    you-should-use
    z
)

# Actually load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


export PATH="/usr/local/Cellar/pyenv-virtualenv/1.2.1/shims:${PATH}";
export PYENV_VIRTUALENV_INIT=1;
_pyenv_virtualenv_hook() {
  local ret=$?
  if [ -n "${VIRTUAL_ENV-}" ]; then
    eval "$(pyenv sh-activate --quiet || pyenv sh-deactivate --quiet || true)" || true
  else
    eval "$(pyenv sh-activate --quiet || true)" || true
  fi
  return $ret
};
typeset -g -a precmd_functions
if [[ -z $precmd_functions[(r)_pyenv_virtualenv_hook] ]]; then
  precmd_functions=(_pyenv_virtualenv_hook $precmd_functions);
fi


export GOPATH=$HOME/GolandProjects
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# Flutter
export FLUTTERPATH=$HOME/development/flutter
export PATH=$PATH:$FLUTTERPATH/bin

export GPG_TTY=\$(tty)

# Created by `pipx` on 2023-07-22 19:43:30
export PATH="$PATH:$HOME/.local/bin"


# airflow setup
export PATH=${PATH}:"$HOME/Projects/airflow"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# START: Added by Updated Airflow Breeze autocomplete setup
source $HOME/Projects/airflow/dev/breeze/autocomplete/breeze-complete-zsh.sh
# END: Added by Updated Airflow Breeze autocomplete setup

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

typeset -a sources
CONFIG_DIR="$HOME/.zsh.d"

sources+="$CONFIG_DIR/alias.zsh"

for file in $sources[@]; do
    if [[ -a $file ]]; then
       source $file
    else
        echo "config file not found: $file"
    fi
done


# Optimize compinit for faster loading
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Starship prompt replaces the OMZ theme

CASE_SENSITIVE="false"
ENABLE_CORRECTION="false"
HIST_STAMPS="mm/dd/yyyy"

zstyle ':omz:update' mode disabled  # :auto; disabled; reminder
zstyle ':omz:update' frequency 15

# History
HISTSIZE=50000                # How many lines of history to keep in memory
HISTFILE=~/.zsh_history       # Where to save history to disk
SAVEHIST=50000                # Number of history entries to save to disk

ZOXIDE_CMD_OVERRIDE=cd

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    you-should-use
    zoxide
    colored-man-pages
)

# Actually load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Initialize Starship prompt
eval "$(starship init zsh)"

# Load custom configs
typeset -a sources
ZSH_CONFIG_DIR="$HOME/.zsh.d"

sources+="$ZSH_CONFIG_DIR/alias.zsh"
sources+="$ZSH_CONFIG_DIR/exports.zsh"
sources+="$ZSH_CONFIG_DIR/functions.zsh"
sources+="$ZSH_CONFIG_DIR/private.zsh"

for file in $sources[@]; do
    if [[ -a $file ]]; then
       source $file
    fi
done

# Lazy-load pyenv - only initialize when needed
pyenv() {
  unfunction "$0"
  eval "$(command pyenv init --path)"
  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"
  $0 "$@"
}

# Load fzf
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  eval "$(command fzf --zsh)"
fi

# fzf-tab: fuzzy completion for ZSH
if [[ -f $ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
  source $ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh
fi

# Atuin: shell history with sync (takes over Ctrl+R)
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

# override with local settings
source ~/.zshrc.local

# Load zsh-autosuggestions and zsh-syntax-highlighting last for better performance
if [[ -f $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load syntax-highlighting absolutely last as it needs to process all previous commands and widgets
if [[ -f $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# uncomment this line to profile zsh startup time
# zprof

# Anything below here was probably added automatically and should be re-adjusted or moved to ~/.zshrc.local

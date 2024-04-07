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

zstyle ':omz:update' mode auto  # :auto; disabled; reminder
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
    gitfast
    zsh-autosuggestions
    zsh-syntax-highlighting
    ohmyzsh-full-autoupdate
    you-should-use
    zoxide
    colored-man-pages
)

# Actually load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# override with local settings
source ~/.zshrc.local

# Anything below here was probably added automatically and should be re-adjusted or moved to ~/.zshrc.local

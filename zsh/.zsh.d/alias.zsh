alias wttr='curl wttr.in/'
alias dotfiles='cd ~/.dotfiles'
alias grep='grep --color=auto'
alias ll='eza -lh'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Improved help
alias help='tldr'

# Replace cat with bat
alias cat='bat'

# Open from the terminal
alias o='open'

# Create a directory and cd into it
mcd() {
    mkdir "${1}" && cd "${1}"
}

# neofetch: https://github.com/dylanaraps/neofetch
command -v neofetch >/dev/null 2>&1 && alias neofetch="neofetch --source $HOME/.config/neofetch/nyancat.ascii"

# Download file and save it with filename of remote file
alias download="curl -O -L"

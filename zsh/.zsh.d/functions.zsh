#!/bin/bash

########################################################################################################################
# Print website to pdf
# function accept two parameters first is url and second is optional filename
# e.g. pdf https://google.com ~/Downloads/google.pdf
# e.h. png https://google.com ~/Downloads/google.png
########################################################################################################################

pdf() { /Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser --headless --disable-gpu --no-pdf-header-footer --no-margins --run-all-compositor-stages-before-draw --print-to-pdf=${2:-print.pdf} $1 > /dev/null 2>&1; }
png() { /Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser --headless --disable-gpu --hide-scrollbars --virtual-time-budget=2000 --window-size=1920,1428 --screenshot=${2:-screenshot.png} $1 > /dev/null 2>&1; }

# Create a directory and cd into it
mcd() {
    mkdir "${1}" && cd "${1}"
}

# Generate a random password of a given length, copy to clipboard
genpass(){
    length="${1:-16}"
    openssl rand -base64 $length | rev | cut -b 2- | rev | pbcopy >/dev/null 2>&1
}

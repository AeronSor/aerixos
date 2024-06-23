# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
#PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '

### ALIAS ### ---------------------------------------------------------
alias ba='nvim ~/.bashrc'
alias src='source ~/.bashrc'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias dot-w='cd ~/.dotfiles-wayland/ && ranger'
alias hype='cd ~/.config/hypr/ && ranger'
alias elko='cd ~/.config/eww/ && ranger'

alias dot-x='cd ~/.dotfiles-xorg/ && ranger'
alias bs='cd ~/.config/bspwm/ && ranger'
alias sx='cd ~/.config/sxhkd/ && ranger'
alias po='cd ~/.config/polybar/ && ranger'

alias dot-g='cd ~/.dotfiles-general/ && ranger'
alias nvcfg='cd ~/Repos/AeroNvim/ && ranger'
alias coding='cd ~/Projects/Coding/ && ranger'

alias awm='cd ~/.config/awesome/ && ranger'

alias band='bandcamp-dl -ferku'

alias aerixos-rebuild='sh ~/Repos/aerixos/scripts/rebuild.sh'
alias aerixos-test='cd ~/Repos/aerixos/ && sudo nixos-rebuild test --flake ~/Repos/aerixos/#aeron'
alias aerixos-edit='cd ~/Repos/aerixos/ && ranger .'

### Put my Scripts on path----------------------------------------------

export PATH=$PATH:~/Scripts/

### --------------------------------------------------------------------

# Helper for running C code without a makefile on the shell
# using Here documents feature.
# Example : 
# $ go_c << '---'
# $ ... code
# $ ---
# $ ./a.out
go_libs="-lm"
go_flags="-g -Wall -include ~/Projects/Coding/C/useful-headers/allheaders.h -O3"
alias go_c="c99 -xc - $go_libs $go_flags"

# Function to make ranger quit and cd to the last dir
function ranger_dir {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

alias ranger=ranger_dir

### MISC ### -----------------------------------------------------------

# Color suport for less, man, etc.
export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP


# Some misc exports
export EDITOR=nvim
export PICO_SDK_PATH=$HOME/Projects/Coding/Pico/pico-lib/pico-sdk/
export PICO_EXTRAS_PATH=$HOME/Projects/Coding/Pico/pico-lib/pico-extras/

eval "$(zoxide init bash)"


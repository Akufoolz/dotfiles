#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

parse_git_branch() {
    # git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function akuprompt {
    FB="\[\033[30m\]"
    BB="\[\033[40m\]"
    FBL="\[\033[34m\]"
    BBL="\[\033[44m\]"
    FC="\[\033[36m\]"
    BC="\[\033[46m\]"
    FP="\[\033[35m\]"
    BP="\[\033[45m\]"
    FW="\[\033[37m\]"
    BW="\[\033[47m\]"
    END="\[\033[00m\]"
    # export PS1="$BB$FP░▒▓$BP$FB \u@\h $BB$FP▓▒░ \w ░ \$ "
    # export PS1="$BP$FB \u@\h $BBL$FP▓▒░$FW \w $FW░$FW \$ $END"
    # export PS1="$BP$FB \u@\h $BC$FP▓▒░$BC$FB \w $BB$FBL▓▒░$FC master \n\$$END "
    # export PS1="$BC$FB \u$FBL@$FB\h $BP$FC▓▒░$BP$FB \w $BBL$FP▓▒░$FB master \n$END$FP\$$END "
    # export PS1="$BBL$FW \u$FC@$FW\h $BP$FBL▓▒░$BP$FB \w $BC$FP▓▒░$FB master $BB$FC▓▒░\n$END$FP\$$END "

    # Use this one
    export PS1="$BC$FB \u$FBL@$FB\h $BP$FC▓▒░$BP$FB \w $BBL$FP▓▒░$FB \$(parse_git_branch) $END$BB$FBL▓▒░\n$END$FP\$$END "
}

akuprompt

# export PS1="\[\033[38;5;12m\][\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;12m\]@\[$(tput sgr0)\]\[\033[38;5;7m\]\h\[$(tput sgr0)\]\[\033[38;5;12m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;7m\]\w\[$(tput sgr0)\]\[\033[38;5;12m\]>\[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

[ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "`dircolors -b $DIR_COLORS`"

EDITOR=vim
PAGER=more

mkcd () {
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}

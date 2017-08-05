alias ll="ls -lhL"
alias la="ls -lahL"
alias l.="ls -ld .*"
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export EDITOR="vim"
export CLICOLOR=1
export HISTSIZE=10000
export HISTFILESIZE=5000

# Prompt with timer setup and previous command setup
function timer_start {
    timer=${timer:-$SECONDS}
}

function timer_stop {
    timer_show=$(($SECONDS - $timer))
    if ((timer_show < 120)); then
        timer_show="${timer_show}s"
    else
        timer_show=$((timer_show / 60))
        if ((timer_show < 120)); then
            timer_show="${timer_show}m"
        else
            timer_show=$((timer_show / 60))
            timer_show="${timer_show}h"
        fi
    fi
    unset timer
}

trap 'timer_start' DEBUG

normal="\[\e[0m\]"
red="\[\e[0;31m\]"
orange="\[\e[1;31m\]"
green="\[\e[0;32m\]"
yellow="\[\e[0;33m\]"
blue="\[\e[0;34m\]"
magenta="\[\e[0;35m\]"
violet="\[\e[1;35m\]"
cyan="\[\e[0;36m\]"

export PROMPT_COMMAND=__prompt_command

function __prompt_command {
    local EXIT="${?}"
    timer_stop

    PS1="\n${green}"

    if [ $EXIT != 0 ]; then
        PS1+="${red}"
    fi

    PS1+="${timer_show} ${cyan}\A ${yellow}\w"

    status=$(git status --porcelain 2> /dev/null)

    if [ ${?} -eq 0 ]; then
        PS1+="${green}"
        if [[ ! -z ${status} ]]; then
            PS1+="${red}"
            if [[ $(echo ${status} | grep "^ \|??" -c) -eq 0 ]]; then
                PS1+="${orange}"
            fi
        fi
        branch=$(git branch --no-color 2> /dev/null | grep "*" 2> /dev/null)
        PS1+="${branch#\*}"
    fi

    PS1+="\n${magenta}\$ ${normal}"
}


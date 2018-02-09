# Git tab completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash

  # Tab completion git aliased to g
  __git_complete g __git_main
fi

alias ll="ls -lhL"
alias la="ls -lahL"
alias l.="ls -ld .*"
alias g='git'
alias cfg='g --git-dir=$HOME/.cfg/ --work-tree=$HOME'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export EDITOR="vim"
export CLICOLOR=1
export HISTSIZE=10000
export HISTFILESIZE=5000

# Prompt with timer setup and previous command setup
normal="\[\e[0m\]"
red="\[\e[0;31m\]"
orange="\[\e[1;31m\]"
green="\[\e[0;32m\]"
yellow="\[\e[0;33m\]"
blue="\[\e[0;34m\]"
magenta="\[\e[0;35m\]"
violet="\[\e[1;35m\]"
cyan="\[\e[0;36m\]"

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

function git_color {
    local STATUS="$(git status --porcelain 2> /dev/null)"

    if [ ${?} -eq 0 ]; then
        if [[ ! -z ${STATUS} ]]; then
            if [[ $(echo "${STATUS}" | grep "^ \S \S\|^\S\S \S" -c) == "0" ]]; then
                PS1+="${yellow}"
                return
            fi
            PS1+="${red}"
            return
        fi
        PS1+="${green}"
        return
    fi
    return 1
}

function git_branch {
    branch="$(git branch --no-color 2> /dev/null | grep "*" 2> /dev/null)"
    PS1+="${branch#\*}"
}

if [[ $0 == -bash ]]; then
  export PROMPT_COMMAND="${PROMPT_COMMAND} && __prompt_command"
else
  export PROMPT_COMMAND="__prompt_command"
fi

function __prompt_command {
    local EXIT="${?}"
    timer_stop

    PS1="\n${green}"

    if [ $EXIT != 0 ]; then
        PS1+="${red}"
    fi

    PS1+="${timer_show} ${cyan}\A ${blue}\w"

    git_color && git_branch

    PS1+="\n${magenta}\$ ${normal}"
}

if [ -f ~/.localrc.bash ]; then
    . ~/.localrc.bash
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

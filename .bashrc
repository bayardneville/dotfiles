alias ll='ls -lhF'
alias la='ls -lahF'
alias l.='ls -ld .*'
alias g='git'

alias av='. venv/bin/activate'
alias dv='deactivate'

# quick look from cli
alias ql='qlmanage -p "$@"'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind 'set revert-all-at-newline on'

export BASH_SILENCE_DEPRECATION_WARNING=1
export CDPATH=./:~/:~/dev/:~/Documents/dev/
export CLICOLOR=1
export EDITOR='vim'

HISTSIZE=1000000
HISTFILESIZE=1000000
# ignore whitespace and duplicates
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'

# append instead of overwriting
shopt -s histappend
# group multi-line commands onto one line in history
shopt -s cmdhist

# allow plain directory names to cd: does not work on macos bash :(
# shopt -s autocd
# autocorrect for mispelled directories in cd
shopt -s cdspell

# only complete directories for cd
complete -d cd

if [[ $0 != -bash || -z ${PROMPT_COMMAND} ]]; then
  export PROMPT_COMMAND="__prompt_command"
else
  export PROMPT_COMMAND="${PROMPT_COMMAND} && __prompt_command"
fi

# color variables
# wrapped in brackets to mark as zero-length: "\[$color\]"
normal="\[\e[0m\]"

red="\[\e[31m\]"
green="\[\e[32m\]"
yellow="\[\e[33m\]"
blue="\[\e[34m\]"
magenta="\[\e[35m\]"
cyan="\[\e[36m\]"

bred="\[\e[91m\]"
bgreen="\[\e[92m\]"
byellow="\[\e[93m\]"
bblue="\[\e[94m\]"
bmagenta="\[\e[95m\]"
bcyan="\[\e[96m\]"

# prompt with timer, previous command status, git, venv
mkv() {
    virtualenv -p "$(brew --prefix)/opt/python@${1}/libexec/bin/python" venv && . venv/bin/activate
}

timer_start() {
    timer=${timer:-$SECONDS}
}

timer_stop() {
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

git_color() {
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

git_branch() {
    branch="$(git branch --no-color 2> /dev/null | grep "*" 2> /dev/null)"
    PS1+="${branch#\*}"
}

__prompt_command() {
    local EXIT="${?}"
    timer_stop

    PS1="\n${green}"

    if [ $EXIT != 0 ]; then
        PS1+="${red}"
    fi

    PS1+="${timer_show} ${cyan}\A ${blue}\w"

    git_color && git_branch

    PS1+="${magenta}${VIRTUAL_ENV:+ ($(basename ${VIRTUAL_ENV}))}"
    PS1+="\n${magenta}\$ ${normal}"
}

if [ -f ~/.lbashrc ]; then
    . ~/.lbashrc
fi

# Git tab completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash

  # Tab completion git aliased to g
  __git_complete g __git_main
fi

autoload -Uz colors && colors

timer=0
function preexec() {
    timer=${timer:-$SECONDS}
}

function precmd() {
    EXIT="$?"
    if [[ $timer ]]; then
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
    fi
    unset timer

    PROMPT="%{$fg[cyan]%}[%{$fg[green]%}"

    if [ $EXIT != 0 ]; then
       PROMPT+="%{$fg[red]%}"
    fi

    PROMPT+="${timer_show}%{$fg[cyan]%}]

%{$fg[yellow]%}%~
%{$fg[cyan]%}[%T %n]%#%{$fg[default]%} "
}

export RPROMPT=

bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey '^?' backward-delete-char

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

export EDITOR="vim"
export CLICOLOR=1
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY

alias .=source
alias ll="ls -lh"
alias la="ls -lAh"
alias l.="ls -ld .*"

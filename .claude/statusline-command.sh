#!/usr/bin/env bash
# Claude Code statusLine command: cwd + git branch

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')

blue="\e[34m"
green="\e[32m"
cyan="\e[36m"
yellow="\e[33m"
red="\e[31m"
normal="\e[0m"

# Timestamp — 24-hour HH:MM, cyan to match PS1 \A
time_now=$(date +%H:%M)

# Working directory — abbreviate $HOME as ~
display_cwd="${cwd/#$HOME/\~}"

# Git branch + status-based color (matches PS1 git_color logic)
branch=""
branch_color="$green"
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree &>/dev/null; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    status=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    if [[ -n "$status" ]]; then
        # Check for unstaged changes (lines matching "^ \S \S" or "^\S\S \S")
        if echo "$status" | grep -qE '^ [^ ] |^[^ ][^ ] '; then
            branch_color="$red"
        else
            branch_color="$yellow"
        fi
    fi
fi

# Context usage progress bar
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | xargs printf '%.0f')
bar_width=10
filled=$(( used_pct * bar_width / 100 ))
empty=$(( bar_width - filled ))

if (( used_pct >= 80 )); then
    bar_color="$red"
elif (( used_pct >= 50 )); then
    bar_color="$yellow"
else
    bar_color="$normal"
fi

bar="${bar_color}"
for (( i=0; i<filled; i++ )); do bar+="█"; done
for (( i=0; i<empty; i++ )); do bar+="░"; done
bar+="${normal}"

# Build output — timestamp first, then context indicator, then cwd + branch
output="${cyan}${time_now}${normal} ${bar} ${bar_color}${used_pct}%${normal} ${blue}${display_cwd}"
if [[ -n "$branch" ]]; then
    output+=" ${branch_color}${branch}${normal}"
fi

printf '%b' "$output"

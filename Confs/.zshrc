COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{168}'
COLOR_GIT='%F{14}'

parse_prompt() {
    PROMPT='${COLOR_USR}%n@%m ${COLOR_DIR}%2d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}> '
    echo $PROMPT
}

parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# Set zsh option for prompt substitution
setopt PROMPT_SUBST
export PROMPT=$(parse_prompt)


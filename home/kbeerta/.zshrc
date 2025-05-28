
function git_branch() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]]; then
        :
    else
        echo ' ('$branch')'
    fi
}

setopt prompt_subst
prompt="%F{yellow}%n%f@%F{red}%m%f%F{gray}${IN_NIX_SHELL:+*}%f %F{blue}%1~%f%F{cyan}\$(git_branch)$f %F{magenta}$%f "

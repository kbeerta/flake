function git_branch() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]]; then
        :
    else
        dirty=""
        if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
            dirty="%F{yellow}*%F{blue}"
        fi
        echo ' %F{blue}('$branch$dirty')%f'
    fi
}
setopt prompt_subst
prompt="%F{red}%m%f %F{yellow}at%f %F{gray}%f%F{cyan}%1~%f${IN_NIX_SHELL:+*}\$(git_branch)
%F{magenta}$%f "

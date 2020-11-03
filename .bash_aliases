alias svm="svn st | grep -v ^?"
nv() {
    if [[ -n "$1" ]]; then
        cd "$1"
    fi
    ls
}

if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi


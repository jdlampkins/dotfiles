alias svm="svn st | grep -v ^?"
nv() {
    if [[ -n "$1" ]]; then
        cd "$1"
    fi
    ls
}

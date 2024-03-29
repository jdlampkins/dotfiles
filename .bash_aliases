# Useful for checking for changes in a subervsion directory.
alias svm="svn st | grep -v ^?"

# nv="navigate"
# Combines cd and ls.
nv() {
    if [[ -n "$1" ]]; then
        cd "$1"
    fi
    ls
}

# This forces tmux to assume the terminal supports 256 colors.
alias tmux="tmux -2"

# fp="find process"
alias fp="ps -ef | grep"

# Setting default editor.
if command -v vim &> /dev/null ; then
    export EDITOR=vim
elif command -v vi &> /dev/null ; then
    export EDITOR=vi
fi

# Page through 'tree' output with colors.
treep() {
    tree -C $@ | less -r
}

# Sourcing any local aliases.
if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi


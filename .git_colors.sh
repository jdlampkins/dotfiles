settings=(
'diff.new 106'
'diff.old 66'
'diff.meta 172'
'diff.frag 184'
'diff.plain 229'
'diff.func 229'
'diff.commit 106'
'status.untracked 66'
'status.changed 184'
'status.header 229'
'status.added 106'
'status.branch 172'
'branch.current 106'
'decorate.HEAD 66'
'decorate.branch 106'
'decorate.remoteBranch 172'
)

for setting in "${settings[@]}"; do
    git config --global color.${setting}
done

# Doing this separately, since the quotes cause issues
git config --global color.diff.whitespace "125 reverse"

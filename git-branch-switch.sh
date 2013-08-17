#!/bin/sh
set -e

# changes branch without touching the working copy and resets
# the index to the index corresponding to the new branch

help ()
{
	cat <<EOH
Usage: git-branch-switch <branch-to-switch-to>

  Changes current branch to <branch-to-switch-to> without
  touching the working copy.

  <branch-to-switch-to> - local branch to switch to.

EOH
}

if [ $# -ne 1 ] ; then
	echo "git-branch-switch needs a branch parameter to switch to" 2>&1
	exit 1
fi
if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
	help
	exit 0
fi

ref="refs/heads/$1"
if ! git show-ref --quiet --verify -- "$ref" ; then
	echo "Error: $1 is not a local branch name (switching to tags or remote branches is not supported)." 2>&1
	exit 1
fi
R="$1"

# do the switch
OLDHEAD="$(git show-ref --head HEAD | grep -o '^[0-9a-f]* HEAD$' | grep -o '^[0-9a-f]*')"
[ "$OLDHEAD" ] && POH="$OLDHEAD" || POH='(unknown HEAD)'

echo "Switching HEAD from $POH to $R..."
git symbolic-ref HEAD "$ref" && echo "Updating index..." && git read-tree "$R" && echo "Done."


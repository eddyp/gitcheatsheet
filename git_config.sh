#!/bin/sh


## aliases
git alias br "branch -vv"
git alias ci "commit  --signoff"
git alias lg "log --decorate --graph"
git alias l "log --decorate --graph --oneline"
git alias di diff
git alias st "status"
git alias co "checkout"


## configuration
# personal info
# avoid spam from html parsers
AT=@
git config --global user.email "eddy.petrisor${AT}gmail.com"
git config --global user.name "Eddy Petrișor"

# color in interactive shells
git config --global color.ui auto

# by default, when pulling, accept automatically only fast-forward changes,
# for the rest we want to review first
git config --global pull.ff-only true
## an alternative is to rebase with
## 'git pull --rebase' and 'git rebase --continue'
## or with
#git config --global pull.rebase true               # git >= 1.7.9
#git config --global branch.autosetuprebase always  # git < 1.7.9


# configure Beyond Compare as mergetool (but not set it as default)
BC="bcompare"
BCPATH="$(which ${BC})"
if [ "$BCPATH" ] ; then
	git config --global mergetool.${BC}.path "$BCPATH"
	git config --global mergetool.${BC}.cmd "$BCPATH \"\$PWD/\$LOCAL\" \"\$PWD/\$REMOTE\" \"\$PWD/\$BASE\" \"\$PWD/\$MERGED\""
	git config --global mergetool.${BC}.keepbackup false
	git config --global mergetool.${BC}.trustexitcode false
fi



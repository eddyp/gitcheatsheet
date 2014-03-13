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
BCTOOL="bc3"
BCPATH="$(which ${BC})"
if [ "$BCPATH" ] ; then
	git config --global mergetool.${BCTOOL}.path "$BCPATH"
	git config --global mergetool.${BCTOOL}.cmd "$BCPATH \"\$PWD/\$LOCAL\" \"\$PWD/\$REMOTE\" \"\$PWD/\$BASE\" \"\$PWD/\$MERGED\""
	git config --global mergetool.${BCTOOL}.keepbackup false
	git config --global mergetool.${BCTOOL}.trustexitcode false

	git config --global difftool.${BCTOOL}

fi


# configure Semanticmerge as mergetool (but not set it as default)
SM="semanticmergetool"
SMTOOL="sm"
SMPATH="$(which ${SM})"
if [ -x "$SMPATH" ] ; then
	git config --global mergetool.${SMTOOL}.path "$SMPATH"
	# git config --global mergetool.${SMTOOL}.cmd "$SMPATH -s=\"\$LOCAL\" -d=\"\$REMOTE\" -b=\"\$BASE\" -r=\"\$MERGED\" -edt=\"meld\""
	git config --global mergetool.${SMTOOL}.cmd "$SMPATH -s=\"\$LOCAL\" -d=\"\$REMOTE\" -b=\"\$BASE\" -r=\"\$MERGED\" -edt=default -emt=default -e2mt=default"
	git config --global mergetool.${SMTOOL}.keepbackup false
	git config --global mergetool.${SMTOOL}.trustexitcode false

	git config --global mergetool.${SMTOOL}bc3.path "$SMPATH"
	git config --global mergetool.${SMTOOL}bc3.cmd "$SMPATH -s=\"\$LOCAL\" -d=\"\$REMOTE\" -b=\"\$BASE\" -r=\"\$MERGED\" -edt=\"bcompare \\\"#sourcefile\\\" \\\"#destinationfile\\\" -lefttitle='#sourcesymbolic' -righttitle='#destinationsymbolic'\" -emt=\"bcompare  \\\"#sourcefile\\\" \\\"#destinationfile\\\" \\\"#basefile\\\" \\\"#output\\\" -lefttitle='#sourcesymbolic' -righttitle='#destinationsymbolic' -centertitle='#basesymbolic' -outputtitle='merge result'\" -e2mt=\"bcompare \\\"#sourcefile\\\" \\\"#destinationfile\\\" -savetarget=\\\"#output\\\" -lefttitle='#sourcesymbolic' -righttitle='#destinationsymbolic'\""
	git config --global mergetool.${SMTOOL}bc3.keepbackup false
	git config --global mergetool.${SMTOOL}bc3.trustexitcode false

	git config --global difftool.${SMTOOL}.path "$SMPATH"
	git config --global difftool.${SMTOOL}.cmd "$SMPATH -s=\"\$LOCAL\" -d=\"\$REMOTE\"-edt=\"meld \\\"#sourcefile\\\" \\\"#destinationfile\\\"\" -e2mt=\"meld \\\"#sourcefile\\\" \\\"#destinationfile\\\" \\\"#output\\\""
fi


#!/bin/bash

git config --global core.editor "vim"

git config --global alias.co "checkout"
git config --global alias.ci "commit"
git config --global alias.br "branch"
git config --global alias.st "status"
git config --global alias.pick "cherry-pick"
git config --global alias.last "log -1 HEAD"

cp vimrc ~/.vimrc

grep -q git-completions ~/.bashrc
if [ $? -ne 0 ]; then
	cp git-completions ~/
	echo "[ -f ~/git-completions ] && source git-completions" >> ~/.bashrc
fi


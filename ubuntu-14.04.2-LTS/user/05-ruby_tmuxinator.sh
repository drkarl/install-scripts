#!/bin/bash

echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m============[Installing Ruby]==========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
rvm install ruby

echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m=========[Installing Tmuxinator]=======\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
gem install tmuxinator
git clone https://github.com/tmuxinator/tmuxinator.git ~/tmuxinator.git
source ~/tmuxinator.git/completion/tmuxinator.zsh
rm -rf ~/tmuxinator.git

echo -e "\033[1;32mUser configuration complete!!\033[0m"
